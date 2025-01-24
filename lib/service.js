const express = require('express');
const bodyParser = require('body-parser');
const { executeQuery,db } = require('./db');

const app = express()
const port = 3000

app.use(bodyParser.json());

//登入
app.post('/login',(req,res) => {
    const {email, password} = req.body;
    console.log('Email:', email, 'Password:', password);
    
    const sql = "SELECT * FROM user WHERE email = ?";
    const params = [email];
    executeQuery(sql, params, (error, result) =>{
        console.log('result:', result);
        if (error) {
            console.error('資料庫錯誤:', error.message);
            res.status(500).json({
                success: false,
                message: '資料庫錯誤',
                error: error.message,
            })
        } 
        else if (result.length === 0) {
            return res.status(400).json({ 
                seccess: false,
                message: '帳號不存在' ,
            });
        }
        else if(result[0].password != password){
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

//註冊
app.post('/rigister', (req, res) => {
    const {email, password} = req.body;

    const sql = "SELECT * FROM user WHERE email = ?";
    const params = [email];
    executeQuery(sql, params, (error, result) =>{
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
                message: '帳號已存在' ,
            });
        }
        else{
            const Isql = "INSERT INTO user (email, password) VALUES (?, ?)";
            const Iparams = [email, password];
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
//測試用
app.get('/user', (req, res) => {
    const sql = "SELECT * FROM user";
    const params = [];
    executeQuery(sql, params, (error, result) => {
        if (error) {
            console.error('查詢失敗:', error.message);
            res.status(500).json({
                success: false,
                message: 'Failed to fetch users',
                error: error.message,
            })
        } else {
            console.log('查詢成功:', result);
            res.json({
                success: true,
                users: result,
            });
        }
    });
});
app.get('/', (req, res) => {
    res.json({
        success: true,
        message: "hello",
    });
});

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`)
})