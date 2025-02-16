const express = require('express');
const router = express.Router();
const { executeQuery } = require('../db');//資料庫函式
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const secretKey = '80a1c66e79443f97989d40933dab1721ac66b3838c88383f23f3525b71d2ca5a3058c7addcdf';

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
            const token = jwt.sign({ id: user.id, email: user.email }, 'secretKey', { expiresIn: '1h' });
            return res.json({ 
                success: true, 
                message: '登入成功',
                token,
            });
        }
    })
});

router.get('/user-profile', async (req, res) => {
    const token = req.headers.authorization?.split(' ')[1];
    if (!token) return res.status(401).json({ error: '未授權' });

    try {
        const decoded = jwt.verify(token, 'secretKey');
        const id = decoded.id;
        console.log('routerid',id);

        const sql = "SELECT * FROM user WHERE id = ?";
        const params = [id];

        executeQuery(sql, params, (error, result) => {
            if (error) {
                console.error('資料庫錯誤:', error.message);
                return res.status(500).json({
                    success: false,
                    message: '資料庫錯誤',
                    error: error.message,
                });
            }

            if (result.length === 0) {
                return res.status(404).json({ error: '用戶未找到' });
            }
            const user = result[0];
            res.json({
                id: user.id,
                email: user.email,
                username: user.username, // 假設資料庫有這個欄位
            });
        });

    } catch (error) {
        res.status(403).json({ error: '無效的 Token' });
    }
});

router.get('/pet-profile', async (req, res) => {
    const token = req.headers.authorization?.split(' ')[1];
    if (!token) return res.status(401).json({ error: '未授權' });
    try {
        const decoded = jwt.verify(token, 'secretKey');
        const id = decoded.id;

        sql = "SELECT * FROM pet WHERE userid = ?";
        params = [id];
        executeQuery(sql, params, async(error, result) => {
            if (error) {
                console.error('資料庫錯誤:', error.message);
                return res.status(500).json({
                    success: false,
                    message: '資料庫錯誤',
                    error: error.message,
                });
            }
            console.log('寵物查詢結果',result);
            if (result.length > 0) {
                return res.json({ haspet: true , result: result});
            }else{
                return res.json({ haspet: false });
            }
        })
    }catch(error) {
        res.status(403).json({ error: '無效的 Token' });
    }
})

module.exports = router;