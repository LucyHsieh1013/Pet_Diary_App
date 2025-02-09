const express = require('express');
const router = express.Router();
const { executeQuery } = require('../db');//資料庫函式
const bcrypt = require('bcrypt');

router.post('/', (req, res) => {
    const {email, password} = req.body;
    
    const sql = "SELECT * FROM user WHERE email = ?";
    const params = [email];
    executeQuery(sql, params, async(error, result) =>{
        console.log('result:', result);
        if (error) {
            console.error('資料庫錯誤:', error.message);
            res.status(500).json({
                success: false,
                message: '資料庫錯誤',
                error: error.message,
            })
        } 
        else if (result.length != 0) {
            return res.status(400).json({ 
                seccess: false,
                message: '帳號已存在',
            });
        }
        else{
            const hashedPassword = await bcrypt.hash(password, 10);//加密

            const Isql = "INSERT INTO user (email, password) VALUES (?, ?)";
            const Iparams = [email, hashedPassword];
            executeQuery(Isql, Iparams, (error) =>{
                if (error) {
                    console.error('資料庫錯誤:', error.message);
                    return res.status(500).json({
                        success: false,
                        message: '資料庫錯誤',
                        error: error.message,
                    });
                }
                return res.json({
                    success: true,
                    message: '註冊成功',
                });
            })
        }
    })
})

module.exports = router;