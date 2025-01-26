const express = require('express');
const router = express.Router();
const { executeQuery } = require('../db');//資料庫函式
const bcrypt = require('bcrypt');
const jwt = require("jsonwebtoken");
const nodemailer = require("nodemailer");

const secretKey = "80a1c66e79443f97989d40933dab1721ac66b3838c88383f23f3525b71d2ca5a3058c7addcdfa5300b6d3ed642af70f690d2c8cb3e390a9b4d0890b1eaec79c8aba53406be9464fa6d53493d97a9aa1920e01a91fd2fe9760be5f41344a9961ccca461c2889fce19fe7d7fce3baaa9ba103ba4cceece900d724cddbf76586714ab1fd1b6d59049173e56902eeb2dc5e4e597c2c61c39b880e8e5c5f15a9e6593e236dc7f72598a50098902492ec07d6bd1dab7125fa74b9341697668027f6168ad2d6550e3c018cb20e6e8eb80ee46a9efdbc84f62f49a54a640e045280c2ff48ed75a1fd13b4d9aeed3336ad4dfe70127b7bd02a3f0556935b899955826d2b0"
router.post('/request-reset', (req, res) =>{
    const { email } = req.body;

    const sql = "SELECT id FROM user WHERE email = ?";
    const params = [email];
    console.log("email:",email)
    executeQuery(sql, params, (err, user) => {
        console.log('user:', user);
        if(err || !user){
            return res.status(404).json({
                message: "用戶不存在"
            });
        }

        const token = jwt.sign({ userId: user.id }, secretKey, { expiresIn:"1h" });
        const resetLink = `http://localhost:3000/reset-password/${token}`

        const transporter = nodemailer.createTransport({
            service: "Gmail",
            auth: {
                user: "lucyhsieh1013@gmail.com",
                pass: "20039210"
            }
        })

        const mailOptions = {
            from: "lucyhsieh1013@gmail.com",
            to: email,
            subject: "重設密碼",
            text: `點擊此連結重設密碼: ${resetLink}`,
        };

        transporter.sendMail(mailOptions, (err) => {
            if(err){
                console.log("err:",err);
                return res.status(500).json({
                    message: "郵件發送失敗"
                });
            }
            res.json({
                message: "重設密碼連結已發送至您的信箱"
            })
        })
    })
});

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