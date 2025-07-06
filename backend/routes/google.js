const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const { OAuth2Client } = require('google-auth-library');
const crypto = require('crypto');
const { executeQuery } = require('../db');

const secretKey = '80a1c66e79443f97989d40933dab1721ac66b3838c88383f23f3525b71d2ca5a3058c7addcdf';

const CLIENT_IDS = [
    '458238917861-ebdk3v7bslch3u5bfo2olfh9g8vrf5cf.apps.googleusercontent.com', // Web application
    '458238917861-frcr92j4ge7jlnkhc7bgi5gi30jgf4p8.apps.googleusercontent.com'  // Android client
];
const googleClient = new OAuth2Client();

async function findUserByEmail(email) {
    return new Promise((resolve, reject) => {
        const sql = 'SELECT * FROM user WHERE email = ?';
        executeQuery(sql, [email], (err, results) => {
            if (err) return reject(err);
            resolve(results[0] || null);
        });
    });
}

async function createUser({ email, name }) {
    return new Promise((resolve, reject) => {
        const randomPassword = crypto.randomBytes(8).toString('hex');
        const sql = 'INSERT INTO user (email, username, password) VALUES (?, ?, ?)';
        executeQuery(sql, [email, name, randomPassword], (err) => {
            if (err) return reject(err);
            const fetchSql = 'SELECT * FROM user WHERE email = ?';
            executeQuery(fetchSql, [email], (e2, res2) => {
                if (e2) return reject(e2);
                resolve(res2[0]);
            });
        });
    });
}

router.post('/google', async (req, res) => {
    const { idToken } = req.body;
    if (!idToken) {
        return res.status(400).json({ success: false, message: '缺少 idToken' });
    }

    try {
        const ticket = await googleClient.verifyIdToken({
            idToken,
            audience: CLIENT_IDS,
        });
        const payload = ticket.getPayload();
        const email = payload.email;
        if (!email) {
            return res.status(400).json({ success: false, message: 'Google idToken 無 email 欄位' });
        }


        let user = await findUserByEmail(email);
        if (!user) {
            user = await createUser({ email, name: payload.name });
        }

        const myJwt = jwt.sign({ id: user.id, email: user.email }, secretKey, { expiresIn: '7d' });

        return res.json({
            success: true,
            message: 'Google 登入成功',
            token: myJwt,
            user: { id: user.id, email: user.email, name: user.username || payload.name }
        });
    } catch (err) {
        console.error('Google 驗證失敗', err);
        return res.status(401).json({ success: false, message: '無效的 Google idToken' });
    }
});

module.exports = router;
