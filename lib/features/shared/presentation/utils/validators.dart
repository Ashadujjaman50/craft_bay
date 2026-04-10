import 'package:email_validator/email_validator.dart';

class Validators {

  static String? validateText(String? value, String message){
    if(value == null || value.isEmpty ){
      return message;
    }
    return null;
  }

  static String? validateEmail(
      String? value,
      String emptyMessage,
      String invalidMessage,
      ) {
    final email = value?.trim();

    if (email == null || email.isEmpty) {
      return emptyMessage;
    }

    if (!EmailValidator.validate(email)) {
      return invalidMessage;
    }

    return null;
  }

  static String? validatePassword(String? value){
    if(value == null || value.isEmpty){
      return 'Password is required';
    }
    else if (value.length<6 ){
      return 'Password should at least 6 letter';
    }
    return null;
  }

}