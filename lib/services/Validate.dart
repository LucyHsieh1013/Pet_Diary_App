//驗證
class Validate{
  static String? validateUsername(String? value){
    if(value == null || value.isEmpty){
      return '請輸入使用者名稱';
    }
    if(value.length > 20 || value.length < 1){
      return '使用者名稱長度不得超過20位';
    }
    return null;
  }

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
}