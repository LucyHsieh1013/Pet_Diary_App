import os, json, sys, re
from typing import List, Dict

import faiss
import numpy as np
import torch
from transformers import pipeline, AutoTokenizer
from sentence_transformers import SentenceTransformer
import cv2
from ultralytics import YOLO

# ========= 設定 =========
TEXT_INDEX_PATH = "/home/s11350305/v3/cats_emotion/chi/rag.index"
TEXT_META_PATH = "/home/s11350305/v3/cats_emotion/chi/rag_meta.json"
YOLO_PATH = "/home/s11350305/v3/cats_emotion/Pet_Diary_APP/YOLO/detect/train3/weights/best.pt"
LLM_ID_OR_PATH = "meta-llama/Llama-3.2-3B-Instruct"
EMB_MODEL = "sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2"

TOP_K = 3
MAX_NEW_TOKENS = 700
TEMPERATURE = 0.2
TOP_P = 0.9
CTX_CHAR_BUDGET = 5000

HF_TOKEN = os.getenv("HF_TOKEN") or os.getenv("HUGGINGFACE_HUB_TOKEN")
DTYPE = torch.bfloat16 if torch.cuda.is_available() else torch.float32

# ========= 模型載入 =========
sbert = SentenceTransformer(EMB_MODEL)
tokenizer = AutoTokenizer.from_pretrained(LLM_ID_OR_PATH, use_fast=True)
gen_pipe = pipeline("text-generation", model=LLM_ID_OR_PATH, torch_dtype=DTYPE, device_map="auto")

# ========= 工具函式 =========
def retrieve_text(query: str, k: int = TOP_K) -> List[str]:
    index = faiss.read_index(TEXT_INDEX_PATH)
    with open(TEXT_META_PATH, "r", encoding="utf-8") as f:
        id2text: Dict[str, str] = json.load(f)
    qv = sbert.encode([query], convert_to_numpy=True, normalize_embeddings=True)
    D, I = index.search(qv, k)
    return [id2text.get(str(int(idx)), "") for idx in I[0] if idx != -1]

def build_context(chunks: List[str], budget: int = CTX_CHAR_BUDGET) -> str:
    used, out = 0, []
    for i, ck in enumerate(chunks, 1):
        seg = f"[{i}] {ck.strip()}\n"
        if used + len(seg) > budget:
            break
        out.append(seg)
        used += len(seg)
    return "".join(out)

def clean_output(text: str) -> str:
    text = re.sub(r"Loading .*?LLM pipeline\.\.\.\n*", "", text, flags=re.DOTALL)
    text = re.sub(r"\*", "", text)
    text = re.sub(r"\n\*{1,2}\s*\n", "\n", text)
    return text.strip()

# ========= 建立 LLM 訊息 =========
def build_text_messages(query: str, contexts: List[str]) -> List[Dict[str, str]]:
    system = (
        "你是精通貓咪行為與照護的助理。請優先根據提供的檢索片段回答；"
        "資訊不足時要誠實並提出可行建議。請用繁體中文、條列重點。"
        "不要提到「根據片段」。"
    )
    user = (
        "以下是與本次問題最相關的檢索片段：\n"
        f"{build_context(contexts)}\n\n"
        f"問題：{query}\n\n"
        "請依據片段內容進行回答，最後提供可執行步驟。"
    )
    return [{"role": "system", "content": system}, {"role": "user", "content": user}]

def generate_response(messages: List[Dict[str, str]]) -> str:
    prompt = tokenizer.apply_chat_template(messages, tokenize=False, add_generation_prompt=True)
    output = gen_pipe(prompt, max_new_tokens=MAX_NEW_TOKENS, do_sample=True, temperature=TEMPERATURE, top_p=TOP_P)
    full_text = output[0]["generated_text"]
    if prompt in full_text:
        full_text = full_text.replace(prompt, "")
    return full_text.strip()

# ========= 圖片情緒處理 =========
def handle_image(image_path: str) -> str:
    # 不要讓 YOLO 印出任何訊息
    yolo = YOLO(YOLO_PATH)
    img = cv2.imread(image_path)
    results = yolo(img, verbose=False)

    label = None
    for r in results:
        for box in r.boxes:
            label = r.names[int(box.cls)]

    if not label:
        return "無法偵測到情緒類別，請換一張更清楚的圖片試試看。"

    # 檢索資料
    query = f"貓咪的情緒是{label}，該怎麼辦？"

    with open(TEXT_META_PATH, "r", encoding="utf-8") as f:
        id2text: Dict[str, str] = json.load(f)

    texts = list(id2text.values())
    index = faiss.read_index(TEXT_INDEX_PATH)
    qv = sbert.encode([query], convert_to_numpy=True, normalize_embeddings=True)
    D, I = index.search(qv, k=5)

    retrieved = "\n".join(texts[idx] for idx in I[0] if idx != -1)

    # ========= 指定輸出格式（三段式）=========
    messages = [
        {
            "role": "system",
            "content": (
                "你是一個專門協助貓咪飼主的 AI 助理（Meowmemo）。"
                "請只用繁體中文，不要使用表情符號或奇怪的擬聲詞。"
                "請依照以下格式回答：\n\n"
                "貓咪目前情緒：簡短一句話說明情緒。\n"
                "可能的原因：以 2-4 點條列方式，列出造成此情緒的可能原因。\n"
                "飼主可以怎麼做：以 3-5 點條列方式，提供具體的應對建議。\n\n"
                "不要加入額外前言或結尾，也不要提到「根據資料」等字樣。"
            )
        },
        {
            "role": "user",
            "content": (
                f"模型偵測到我的貓咪的情緒標籤是「{label}」。\n"
                f"以下是相關資料內容：\n{retrieved}\n\n"
                "請依照系統說明的三段格式回答。"
            )
        }
    ]

    return generate_response(messages)

# ========= 純文字查詢 =========
def handle_text(query: str) -> str:
    contexts = retrieve_text(query)
    messages = build_text_messages(query, contexts)
    return generate_response(messages)

# ========= 主程式 =========
def main():
    if len(sys.argv) >= 2:
        q = sys.argv[1]

        if q.endswith(".png") or q.endswith(".jpg") or q.endswith(".jpeg"):
            response = handle_image(q)
        else:
            response = handle_text(q)

        print(clean_output(response))
        sys.stdout.flush()

    else:
        print("錯誤：請提供文字訊息或圖片路徑作為參數")
        sys.stdout.flush()

if __name__ == "__main__":
    main()
