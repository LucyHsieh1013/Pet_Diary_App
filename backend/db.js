const sqlite = require('sqlite3').verbose();
const db = new sqlite.Database('../database/database.db', (err) => {
    if(err){
        console.error('Error connecting to the database:', err.message);
    }else{
        console.log('Connected to the database');
    }
});

function executeQuery(sql, params, callback){
    if(sql.trim().toLowerCase().startsWith("select")){//查詢
        db.all(sql, params, (error, rows) => {
            if (error) {
                callback(error, null); // 發生錯誤時回傳錯誤
            } else {
                callback(null, rows); // 成功時回傳查詢結果
            }
        });
    }else{//新增、刪除、修改
        db.run(sql, params, function (error) {
            if (error) {
                callback(error, null);
            }else{
                callback(null, {changes: this.changes, lastID: this.lastID});
            }
        });
    }
}

//登入及註冊時查找用戶
// function findUserByEmail(email, callback){
//     const sql = "SELECT * FROM user WHERE email = ?";
//     const params = [email];
//     executeQuery(sql, params, (error, result) =>{
//         if (error) {
//             callback(error, null);
//         }else{
//             callback(null, {changes: this.changes, lastID: this.lastID});
//         }
//     })
// }

//測試用
function getUser(callback){
    db.all("SELECT * FROM user",[], function(error, rows) {
        if(error){
            callback(error,null);
        }else{
            callback(null, rows);
        }
    });
}

module.exports = {
    db,
    getUser,
    executeQuery,
    // findUserByEmail,
};