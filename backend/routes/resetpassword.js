const express = require('express');
const router = express.Router();
const { executeQuery } = require('../db');
const bcrypt = require('bcrypt');
const jwt = require("jsonwebtoken");
const nodemailer = require("nodemailer");

const secretKey = '80a1c66e79443f97989d40933dab1721ac66b3838c88383f23f3525b71d2ca5a3058c7addcdf';
const vertificationCode = new Map();// 存取請求驗證碼的email、其驗證碼、時效

// 隨機生成驗證碼
function generatevertificationCode(){
    return Math.floor (100000 + Math.random() * 900000).toString();
}

// 請求驗證碼
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

            const Id = result[0].id;//使用者id
            vertificationCode.delete(email);// 刪除舊的，確保該email僅對應一組驗證碼
            const code = generatevertificationCode();
            const expiry = Date.now() + 1 * 60 * 1000;
            vertificationCode.set(email, { code, expiry });

            const token = jwt.sign({ id: Id, email }, secretKey, { expiresIn: "1m" });// expiresIn: token(驗證碼)有效時間

            const body = `您的驗證碼是:  ${code} ，請於一分鐘內完成驗證。`;

            let transporter = nodemailer.createTransport({
                host: "mail.cs.thu.edu.tw",
                port: 587,
                secure: false,
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
                res.status(200).json({ success: true, message: "郵件已發送", token });
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

// 驗證碼認證
router.post("/verify-code", (req,res) =>{
    const { token, code } = req.body;
    // console.log('接收的資料:',token, code)
    if(!token || !code){
        return res.status(400).json({message: "請輸入驗證碼"})
    }

    try {
        decoded = jwt.verify(token, secretKey);
    } catch (error) {
        if (error.name === "TokenExpiredError") {
            return res.status(400).json({ message: "驗證碼已過期"});
        }
        return res.status(400).json({ message: "無效的 Token" });
    }

    const id = decoded.id
    const email = decoded.email;
    const data = vertificationCode.get(email);
    // console.log('id:', id);

    if(data.code != code){
        return res.status(400).json({ message: "驗證碼錯誤" })
    }

    const resettoken = jwt.sign({ id: id, email }, secretKey, { expiresIn: "10m" });//驗證成功後給一組修改密碼的token
    vertificationCode.delete(email);
    res.json({ message: "驗證成功", resettoken })
})  

// 修改密碼
router.post('/reset-password', (req, res) =>{
    const { resettoken, newpassword } = req.body;
    if(!resettoken || !newpassword){
        return res.status(400).json({message: "請輸入驗證碼"})
    }

    try {
        decoded = jwt.verify(resettoken, secretKey);
    } catch (error) {
        if (error.name === "TokenExpiredError") {
            return res.status(400).json({ message: "驗證碼已過期", success: false });
        }
        return res.status(400).json({ message: "無效的 Token" });
    }

    const id = decoded.id
    // const email = decoded.email; 
    const hashedPassword = bcrypt.hashSync(newpassword, 10);//加密
    const sql = "UPDATE user SET password = ? WHERE id = ?";
    const params = [hashedPassword, id];
    executeQuery(sql, params, (err) => {
        if(err){
            return res.status(404).json({
                message: "密碼更新失敗"
            });
        }
        res.json({ message: "密碼更新成功" });
    })
    // try{
    //     const decoded =  jwt.verify(resettoken, secretKey);//驗證
    //     const id = decoded.id
    //     const email = decoded.email;    
    //     console.log('修改資料:',id,email )
    //     const hashedPassword = bcrypt.hashSync(newpassword, 10);

        
    // }catch (err) {
    //     res.status(400).json({ 
    //         message: "token無效或已過期"
    //     });
    // }
});
    
module.exports = router;