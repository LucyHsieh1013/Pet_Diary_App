//註冊驗證
class Validate{
  //測試帳號
  final Map<String, String> users = {
    'test': '123456',
  };
  
  static String? validateEmail(String? value){
    if(value == null || value.isEmpty){
      return '請輸入Email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+.[^@]');
    if(!emailRegex.hasMatch(value)){
      return '請輸入正確格式的Email';
    }
    return null;
  }
  static String? validatePassword(String? value){
    if(value == null || value.isEmpty){
      return '請輸入密碼';
    }
    if(value.length < 6 || value.length > 8){
      return '密碼長度應為6~8位';
    }
    return null;
  }
  static String? confirmPassword(String? password, String? confirmPssword){
    if(confirmPssword == null || confirmPssword.isEmpty){
      return '請輸入確認密碼';
    }
    if(password != confirmPssword){
      return '密碼與確認密碼不相同';
    }
    return null;
  }

  String? login(String? email, String? password){
    if(email == null || email.isEmpty){
      return '請輸入Email';
    }
    if(password == null || password.isEmpty){
      return '請輸入密碼';
    }
    if(!users.containsKey(email)){
      return '帳號不存在';
    }
    if(users[email] != password){
      return '密碼錯誤';
    }
    return null;
  }
}

//登入驗證
// class LoginValidate {
//   //測試資料
//   final Map<String, String> users = {
//     'testuser@gmail.com': '123456',
//   };
//   String? login(String? email, String? password){
//     if(email == null || email.isEmpty){
//       return '請輸入Email';
//     }
//     if(password == null || password.isEmpty){
//       return '請輸入密碼';
//     }
//     if(!users.containsKey(email)){
//       return '帳號不存在';
//     }
//     if(users[email] != password){
//       return '密碼錯誤';
//     }
//     return null;
//   }
// }
  