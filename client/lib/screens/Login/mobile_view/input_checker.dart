// ignore_for_file: camel_case_types
import 'package:email_validator/email_validator.dart';

class input_checker {
  String? checkInfo(String password, String secondPassword, String email, String name){
    RegExp regEx = RegExp(r"(?=.*[a-z])(?=.*[A-Z])\w+");

    if (email.isEmpty || name.isEmpty || password.isEmpty || email.isEmpty) {
      return "you must fill out all required fields";
    }
    if (password.length < 8) {
      return "Password length must be above 8 characters";
    }
    if (regEx.hasMatch(password) == false) {
      return "Password must contain at least one upper and one lower character";
    }
    if (identical(secondPassword,password)){
      return "The two passwords must be the same";
    }
    if (!EmailValidator.validate(email)){
      return "Email is not valid";
    }

    return null;
  }
}