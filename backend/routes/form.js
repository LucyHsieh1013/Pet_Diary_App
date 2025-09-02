const express = require('express');
const router = express.Router();
const { executeQuery } = require('../db');
// const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

router.post('/addpet', async (req, res) => {
    const{token, name, variety, gender, birthday} = req.body
    console.log('name:', name, variety, gender, birthday);
    console.log('token:',token);
    if (!token) return res.status(401).json({ error: '未授權' });
    try {
        const decoded = jwt.verify(token, 'secretKey');
        const userid = decoded.id;
        console.log('userid:', userid);

        sql = "INSERT INTO pet (userid, name, variety, gender, birthday) VALUES (?, ?, ?, ?, ?)";
        params = [userid, name, variety, gender, birthday];
        executeQuery(sql, params, async(error, result) => {
            if (error) {
                console.error('資料庫錯誤:', error.message);
                return res.status(500).json({
                    success: false,
                    message: '資料庫錯誤',
                    error: error.message,
                });
            }
            return res.status(200).json({
                success: true,
                message: '寵物註冊成功',
            });
        })
    }catch(error) {
        res.status(403).json({ error: '無效的 Token' });
    }
})

router.post('/updatepet', async (req, res) => {
    const{token, name, variety, gender, birthday, id} = req.body
    console.log('name:', name, variety, gender, birthday, id);
    console.log('token:',token);
    if (!token) return res.status(401).json({ error: '未授權' });
    try {
        // const decoded = jwt.verify(token, 'secretKey');
        // const userid = decoded.id;
        // console.log('userid:', userid);

        sql = "UPDATE pet SET name = ?, variety = ?, gender = ?, birthday = ? WHERE id = ?";
        params = [name, variety, gender, birthday, id];
        executeQuery(sql, params, async(error, result) => {
            if (error) {
                console.error('資料庫錯誤:', error.message);
                return res.status(500).json({
                    success: false,
                    message: '資料庫錯誤',
                    error: error.message,
                });
            }
            return res.status(200).json({
                success: true,
                message: '資料更新成功',
            });
        })
    }catch(error) {
        res.status(403).json({ error: '無效的 Token' });
    }
})

router.post('/updateuser', async (req, res) => {
    const{token, username, email} = req.body
    console.log('name:', username, email);
    console.log('token:',token);
    if (!token) return res.status(401).json({ error: '未授權' });
    try {
        const decoded = jwt.verify(token, 'secretKey');
        const id = decoded.id;
        console.log('userid:', id);

        sql = "UPDATE user SET username = ?, email = ? WHERE id = ?";
        params = [username, email, id];
        executeQuery(sql, params, async(error, result) => {
            if (error) {
                console.error('資料庫錯誤:', error.message);
                return res.status(500).json({
                    success: false,
                    message: '資料庫錯誤',
                    error: error.message,
                });
            }
            return res.status(200).json({
                success: true,
                message: '資料更新成功',
            });
        })
    }catch(error) {
        res.status(403).json({ error: '無效的 Token' });
    }
})
module.exports = router;