const express = require('express');
const router = express.Router();
const { executeQuery } = require('../db');
// const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const secretKey = '80a1c66e79443f97989d40933dab1721ac66b3838c88383f23f3525b71d2ca5a3058c7addcdf';

router.post('/addpet', async (req, res) => {
    const{token, name, variety, gender, birthday, date} = req.body
    console.log('name:', name, variety, gender, birthday, date);
    console.log('token:',token);
    if (!token) return res.status(401).json({ error: '未授權' });
    try {
        const decoded = jwt.verify(token, 'secretKey');
        const userid = decoded.id;
        console.log('userid:', userid);

        sql = "INSERT INTO pet (userid, name, variety, gender, birthday, date) VALUES (?, ?, ?, ?, ?, ?)";
        params = [userid, name, variety, gender, birthday, date];
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

module.exports = router;