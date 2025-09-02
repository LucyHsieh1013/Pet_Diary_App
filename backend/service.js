const express = require('express');
const bodyParser = require('body-parser');
const loginRoute = require('./routes/login');
const registerRoute = require('./routes/register');
const resetpasswordRoute = require('./routes/resetpassword');
const formRoute = require('./routes/form');
const googleRoute = require('./routes/google');
const llamaRouter = require("./routes/llama");
const cors = require("cors");

const { executeQuery } = require('./db');//資料庫函式

const app = express()
require('dotenv').config();
const port = process.env.PORT ?? 3000;
const host = process.env.HOST ?? '0.0.0.0';
console.log('host:', host);
app.use(cors({
  // 允許 http://localhost:任意埠 / 127.0.0.1:任意埠
  origin: [/^http:\/\/localhost:\d+$/, /^http:\/\/127\.0\.0\.1:\d+$/],
  credentials: true, // 若用 cookie/會話需要；不用可關
  methods: ['GET','POST','PUT','DELETE','OPTIONS'],
  allowedHeaders: ['Content-Type','Authorization'],
}));
app.options('*', cors());

app.use(bodyParser.json());

app.use("/upload", llamaRouter);
app.use('/login', loginRoute);
app.use('/register', registerRoute);
app.use('/resetpassword', resetpasswordRoute);
app.use('/form', formRoute);
app.use('/auth', googleRoute);

app.listen(port, host, () => {
  const shown = host === '0.0.0.0' ? 'localhost' : host;
  console.log(`Server running at http://${shown}:${port}`);
});

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
