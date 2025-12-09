const express = require("express");
const router = express.Router();
const multer = require("multer");
const { spawn } = require("child_process");

// 檔案儲存設定
const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, "uploads"),
  filename: (req, file, cb) => cb(null, Date.now() + "-" + file.originalname),
});
const upload = multer({ storage: storage });

// 接收純文字或圖片
router.post("/", upload.single("image"), async (req, res) => {
    console.log("=== 📩 新請求收到 ===");
    console.log("req.body:", req.body);
    console.log("req.file:", req.file);
  
    try {
    // 情況一：純文字訊息
    if (req.body.message && !req.file) {
      const message = req.body.message;
      const python = spawn("python3", ["/home/s11350305/v3/cats_emotion/Pet_Diary_APP/YOLO/llama.py", message]);

      let result = "";
      python.stdout.on("data", (data) => {
        result += data.toString();
      });

      python.stderr.on("data", (data) => {
        console.error("Python 錯誤：", data.toString());
      });

      python.on("close", () => {
        res.json({ response: result.trim() });
      });

    // 情況二：圖片
    } else if (req.file) {
      const filePath = req.file.path;
      const python = spawn("python3", ["/home/s11350305/v3/cats_emotion/Pet_Diary_APP/YOLO/llama.py", filePath]);

      let result = "";
      python.stdout.on("data", (data) => {
        result += data.toString();
      });

      python.stderr.on("data", (data) => {
        console.error("Python 錯誤：", data.toString());
      });

      python.on("close", () => {
        res.json({ response: result.trim() });
      });
    } else {
      res.status(400).json({ error: "缺少訊息或圖片" });
    }
  } catch (err) {
    console.error("後端錯誤：", err);
    res.status(500).json({ error: "伺服器錯誤" });
  }
});

module.exports = router;
