import 'package:payroll_system/utils/messaging.dart';

class FieldValidation {
  String? validateUserName(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterYourname;
    } else {
      return null;
    }
  }

  String? validateFirstName(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterYourFirstName;
    } else {
      return null;
    }
  }

  String? validateMiddleName(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterYourMiddleName;
    } else {
      return null;
    }
  }

  String? validateCurrentPassword(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterYourCurrentPassword;
    } else {
      return null;
    }
  }

  String? validateLastName(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterYourLastName;
    } else {
      return null;
    }
  }

  String? validateMobileNumber(String value) {
    String patttern = AppMessage.pattternRegx;
    RegExp regExp = RegExp(patttern);

    if (value.isEmpty) {
      return AppMessage.pleaseEnterPhoneNumber;
    } else if (value.length != 10) {
      return AppMessage.mobileNumberMustTenDigits;
    } else if (!regExp.hasMatch(value)) {
      return AppMessage.mobileNumberMustbeDigits;
    } else {
      return null;
    }
  }

  String? validateCurrentAddress(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterYourCurrentAddress;
    } else {
      return null;
    }
  }

  String? validateCompanyAddress(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterYourCompanyAddress;
    } else {
      return null;
    }
  }

  //location
  String? validateLocationName(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterYourLocation;
    } else {
      return null;
    }
  }

  String? validateAddress(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterYourAddress;
    } else {
      return null;
    }
  }

  String? validateHomeAddress(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterYourHomeAddress;
    } else {
      return null;
    }
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return AppMessage.emailAddressIsRequired;
    } else if (!isNumeric(value) &&
        !RegExp(AppMessage.emailRegExp).hasMatch(value)) {
      return AppMessage.invalidEmailAddress;
    } else {
      return null;
    }
  }

  bool isNumeric(String s) {
    if (s.isEmpty) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  String? validateDepartmentId(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterDepartmentId;
    } else {
      return null;
    }
  }

  String? validateCompanyId(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterCompanyId;
    } else {
      return null;
    }
  }

  String? validateCompanyName(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterCompanyName;
    } else {
      return null;
    }
  }

  String? validateDepartmentName(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterDepartmentName;
    } else {
      return null;
    }
  }

  String? validateHomePhoneNumber(String value) {
    String patttern = AppMessage.pattternRegx;
    RegExp regExp = RegExp(patttern);

    if (value.isEmpty) {
      return AppMessage.pleaseEnterPhoneNumber;
    } else if (value.length != 10) {
      return AppMessage.mobileNumberMustTenDigits;
    } else if (!regExp.hasMatch(value)) {
      return AppMessage.mobileNumberMustbeDigits;
    } else {
      return null;
    }
  }

  // String? validateHomePhoneNumber(String value) {
  //   if (value.isEmpty) {
  //     return 'Please enter Mobile number';
  //   } else if (value.length < 10) {
  //     return 'Mobile number must enter 10 characters';
  //   } else if (value.length > 10) {
  //     return 'Mobile number enter 10 characters';
  //   } else {
  //     return null;
  //   }
  // }

  String? validateWorkPhoneNumber(String value) {
    String patttern = AppMessage.pattternRegx;
    RegExp regExp = RegExp(patttern);

    if (value.isEmpty) {
      return AppMessage.pleaseEnterPhoneNumber;
    } else if (value.length != 10) {
      return AppMessage.mobileNumberMustTenDigits;
    } else if (!regExp.hasMatch(value)) {
      return AppMessage.mobileNumberMustbeDigits;
    } else {
      return null;
    }
  }

  String? validateDateOfBirth(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterYourDateOfBirth;
    } else {
      return null;
    }
  }

  String? validateHourlyRate(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterHourlyRate;
    } else {
      return null;
    }
  }

  String? validateSalary(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterSalary;
    } else {
      return null;
    }
  }

  String? validateStartDayWork(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterFirstDayWork;
    } else {
      return null;
    }
  }

 String? validateEndDayWork(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterLastDayWork;
    } else {
      return null;
    }
  }

  String? validateLastDayWork(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterLastDayWork;
    } else {
      return null;
    }
  }

  // String? validateZipCode(String value) {
  //   if (value.isEmpty) {
  //     return 'Please enter zipCode';
  //   } else {
  //     return null;
  //   }
  // }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return AppMessage.passwordIsRequired;
    } else if (value.length < 8) {
      return AppMessage.passwordMustBeAtleast8CharactersLong;
    } else {
      return null;
    }
  }

  String? validateConfirmPassword(String value, String passwordValue) {
    if (value.isEmpty) {
      return AppMessage.confirmPasswordIsRequired;
    } else if (value.length < 8) {
      return AppMessage.confirmPasswordMustBeAtLeast8CharactersLong;
    } else if (value != passwordValue) {
      return AppMessage.newPasswordAndConfirmpasswordMustBeSame;
    } else {
      return null;
    }
  }
}
