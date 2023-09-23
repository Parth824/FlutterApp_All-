class Helper{

  Helper._();

  static final Helper helper = Helper._();

  RegExp name = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
  // ignore: non_constant_identifier_names
  RegExp pass_valid =
      RegExp(r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~_]).{8,}$');

  RegExp emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  // password validatoon
  bool validateStructure(String pass) {
    String password1 = pass.trim();
    if (pass_valid.hasMatch(password1)) {
      return true;
    } else {
      return false;
    }
  }

  //name validation
  bool validateStructurename(String nam) {
    String nm = nam.trim();
    if (name.hasMatch(nm)) {
      return true;
    } else {
      return false;
    }
  }

  //email validation
  bool validateStructureemail(String email) {
    String email1 = email.trim();
    if (emailValid.hasMatch(email1)) {
      return true;
    } else {
      return false;
    }
  }
  // validator: (value) {
  //                   if (_nameFieldTouched) {
  //                     if (value == null || value.isEmpty) {
  //                       return '* Required';
  //                     } else {
  //                       if (validateStructurename(value)) {
  //                         return "Enter a Valid Name";
  //                       } else {
  //                         return null;
  //                       }
  //                     }
  //                   }
  //                   return null;
  //                 },
  //                 validator: (value) {
  //                   if (_emailFieldTouched) {
  //                     if (value == null || value.isEmpty) {
  //                       return '* Required';
  //                     } else {
  //                       if (validateStructureemail(value)) {
  //                         return null;
  //                       } else {
  //                         return "Enter a valid Email";
  //                       }
  //                     }
  //                   } else {
  //                     return null;
  //                   }
  //                 },
  //                 validator: (value) {
  //                   if (_passwordFieldTouched) {
  //                     if (value == null || value.isEmpty) {
  //                       return '* Required';
  //                     } else {
  //                       if (validateStructure(value)) {
  //                         return null;
  //                       } else {
  //                         return "Password must be least 8 chars, 1 uppercase, 1 lowercase, 1 number, special chars";
  //                       }
  //                     }
  //                   } else {
  //                     return null;
  //                   }
  //                 }
  //                 if (_confirmpasswordFieldTouched) {
  //                     if (value == null || value.isEmpty) {
  //                       return '* Required';
  //                     } else {
  //                       if (cpassword.text == password.text) {
  //                         return null;
  //                       } else {
  //                         return "Confirm Password Didn't Match";
  //                       }
  //                     }
  //                   } else {
  //                     return null;
  //                   }
  //                 },
}