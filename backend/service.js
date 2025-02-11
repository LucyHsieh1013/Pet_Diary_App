const express = require('express');
const bodyParser = require('body-parser');
const loginRoute = require('./routes/login');
const registerRoute = require('./routes/register');
const resetpasswordRoute = require('./routes/resetpassword');
const formRoute = require('./routes/form');

const { executeQuery } = require('./db');//資料庫函式

const app = express()
const port = 3000

app.use(bodyParser.json());

app.use('/login', loginRoute);
app.use('/register', registerRoute);
app.use('/resetpassword', resetpasswordRoute);
app.use('/form', formRoute);

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`)
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
