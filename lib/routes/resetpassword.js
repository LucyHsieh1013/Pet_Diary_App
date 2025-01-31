const express = require('express');
const router = express.Router();
const { executeQuery } = require('../db'); // 資料庫函式
const bcrypt = require('bcrypt');
const jwt = require("jsonwebtoken");
const nodemailer = require("nodemailer");

const secretKey = '80a1c66e79443f97989d40933dab1721ac66b3838c88383f23f3525b71d2ca5a3058c7addcdf';

router.post('/request-reset', async (req, res) => {
    const { email } = req.body;

    if (!email) {
        return res.status(400).json({ message: "請輸入email" });
    }

    try {
        const sql = "SELECT id FROM user WHERE email = ?";
        const params = [email];
        executeQuery(sql, params, async (err, result) => {
            if (err) {
                console.error("查詢錯誤:", err);
                return res.status(500).json({ message: "伺服器錯誤" });
            }
            console.log('result:',result);
            if (result.length === 0) {
                return res.status(404).json({ message: "用戶不存在" });
            }

            const userId = result[0].id;
            const token = jwt.sign({ userId }, secretKey, { expiresIn: "1h" });
            const resetLink = `http://localhost:3000/reset-password/${token}`;

            const body = `請點擊以下連結來重設您的密碼: ${resetLink}`;

            let transporter = nodemailer.createTransport({
                host: "mail.cs.thu.edu.tw",
                port: 587,
                secure: false, // 587 使用 STARTTLS，故 secure 設為 false
                auth: {
                    user: "nmg@cs.thu.edu.tw",
                    pass: "e04su3su;6"
                },
                tls: {
                    rejectUnauthorized: false
                }
            });

            let mailOptions = {
                from: '"驗證碼" <nmg@cs.thu.edu.tw>',
                to: email,
                subject: "驗證碼",
                text: body
            };

            try {
                let info = await transporter.sendMail(mailOptions);
                console.log("郵件已發送: " + info.messageId);
                res.json({ success: true, message: "郵件已發送" });
            } catch (error) {
                console.error("郵件發送錯誤:", error);
                res.status(500).json({ success: false, message: "郵件發送失敗", error });
            }
        });
    } catch (error) {
        console.error("伺服器錯誤:", error);
        res.status(500).json({ message: "伺服器錯誤" });
    }
});

module.exports = router;


router.post('/reset-password', (req, res) =>{
    const { token, newpassword } = req.body;

    try{
        const decoded =  jwt.verify(token, secretKey);//驗證
        const hashedPassword = bcrypt.hashSync(newpassword, 10);

        const sql = "UPDATE user SET password = ? WHERE id = ?";
        const params = [hashedPassword, decoded.id];
        executeQuery(sql, params, (err) => {
            if(err){
                return res.status(404).json({
                    message: "密碼更新失敗"
                });
            }
            res.json({ message: "密碼更新成功" });
        })
    }catch (err) {
        res.status(400).json({ 
            message: "token無效或已過期"
        });
    }
});
    
module.exports = router;