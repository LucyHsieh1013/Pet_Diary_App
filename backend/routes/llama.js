const express = require("express");
const multer = require("multer");
const { spawn } = require("child_process");
const fs = require("fs");
const path = require('path');

const router = express.Router();
const upload = multer({ dest: "uploads/" });

router.post('/', upload.single('image'), (req, res) => {
    const imagePath = req.file.path;

    const llamaScript = path.resolve(__dirname, '../../../Yolo/llama.py');
    console.log('🔍 Python 腳本路徑:', llamaScript);

    const python = spawn('python', [llamaScript, imagePath]);

    let result = '';

    python.stdout.on('data', (data) => {
        const text = data.toString();
        result += text;
        console.log('[Python 輸出]:', text);
    });

    python.stderr.on('data', (data) => {
        console.error('[Python 錯誤]:', data.toString());
    });

    python.on('close', (code) => {
    fs.unlinkSync(imagePath);
    if (code !== 0) {
        console.log(`[Python 結束] code=${code}`);
        return res.status(500).send('Python 腳本執行錯誤');
    }

    // console.log('Python 完整輸出(原始字串):', JSON.stringify(result));

    // 擷取 JSON 字串（第一個 { 到最後一個 }）
    const firstBrace = result.indexOf('{');
    const lastBrace = result.lastIndexOf('}');
    if (firstBrace === -1 || lastBrace === -1) {
        console.error('找不到有效的 JSON 資料');
        return res.status(500).send('回傳內容無效');
    }
    const jsonString = result.substring(firstBrace, lastBrace + 1);

    try {
        const parsed = JSON.parse(jsonString);
        // const generatedText = parsed.generated_text; // 這裡是字串
        let generatedText = '';

        if (Array.isArray(parsed.generated_text)) {
            const assistantMsg = parsed.generated_text.find(
                item => item.role === 'assistant'
            );
            if (assistantMsg) {
                generatedText = assistantMsg.content;
            }
        } else if (typeof parsed.generated_text === 'string') {
            generatedText = parsed.generated_text;
        }
        
        // 直接回傳純文字
        res.status(200).json({ generated_text: generatedText });
    } catch (err) {
        console.error('JSON parse 錯誤:', err);
        res.status(500).send('回傳內容非 JSON 格式');
    }
    python.stdout.on('data', (data) => {
        result += data.toString();
    });

    });
});


module.exports = router;
