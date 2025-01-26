const express = require('express');
const router = express.Router();
const { executeQuery } = require('../db');//資料庫函式
const bcrypt = require('bcrypt');

//登入
router.post('/',(req,res) => {
    const {email, password} = req.body;
    console.log('Email:', email, 'Password:', password);
    
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
        if (result.length === 0) {
            return res.status(400).json({ 
                seccess: false,
                message: '帳號不存在' ,
            });
        }

        const user = result[0];
        const isMatch = await bcrypt.compare(password, user.password);//解密
        // 驗證密碼
        if(!isMatch){
            return res.status(400).json({ 
                success: false, 
                message:'密碼錯誤', 
            });
        }else{
            return res.json({ 
                success: true, 
                message: '登入成功',
            });
        }
    })
});

module.exports = router;