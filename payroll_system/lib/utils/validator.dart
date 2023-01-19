import 'package:payroll_system/utils/messaging.dart';

class FieldValidation {
  String? validateUserName(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterYourName;
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
    String pattern = AppMessage.patternRegX;
    RegExp regExp = RegExp(pattern);

    if (value.isEmpty) {
      return AppMessage.pleaseEnterPhoneNumber;
    } else if (value.length != 10) {
      return AppMessage.mobileNumberMustTenDigits;
    } else if (!regExp.hasMatch(value)) {
      return AppMessage.mobileNumberMustBeDigits;
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

  String? validateCity(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterCity;
    } else {
      return null;
    }
  }

  String? validateState(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterState;
    } else {
      return null;
    }
  }

  String? validateTown(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterTown;
    } else {
      return null;
    }
  }

  String? validateStreetAddress(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterStreetAddress;
    } else {
      return null;
    }
  }

  String? validateLandmarkAddress(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterLandmarkAddress;
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
    String patttern = AppMessage.patternRegX;
    RegExp regExp = RegExp(patttern);

    if (value.isEmpty) {
      return AppMessage.pleaseEnterPhoneNumber;
    } else if (value.length != 10) {
      return AppMessage.mobileNumberMustTenDigits;
    } else if (!regExp.hasMatch(value)) {
      return AppMessage.mobileNumberMustBeDigits;
    } else {
      return null;
    }
  }

  String? validateWorkPhoneNumber(String value) {
    String pattern = AppMessage.patternRegX;
    RegExp regExp = RegExp(pattern);

    if (value.isEmpty) {
      return AppMessage.pleaseEnterPhoneNumber;
    } else if (value.length != 10) {
      return AppMessage.mobileNumberMustTenDigits;
    } else if (!regExp.hasMatch(value)) {
      return AppMessage.mobileNumberMustBeDigits;
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

  String? validateZipCode(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterZipCode;
    } else if (value.length < 4) {
      return AppMessage.zipCode5CharacterLength;
    } else if (value.length > 6) {
      return AppMessage.zipCode6CharacterLength;
    } else {
      return null;
    }
  }

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
      return AppMessage.newPasswordAndConfirmPasswordMustBeSame;
    } else {
      return null;
    }
  }

  //payroll
  String? validateOverTime(String value) {
    if (value.isEmpty) {
      return AppMessage.overtimeIsRequired;
    } else {
      return null;
    }
  }

  String? validatePayDayWork(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterPayDayWork;
    } else {
      return null;
    }
  }

//paycheckvalidator

  String? validateStartDate(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterStartDate;
    } else {
      return null;
    }
  }

  String? validateEndDate(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterEndDate;
    } else {
      return null;
    }
  }

  String? validatePayDate(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterPayDate;
    } else {
      return null;
    }
  }

  String? validateRegularRate(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterRegularRate;
    } else {
      return null;
    }
  }

  String? validateOt(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterOt;
    } else {
      return null;
    }
  }

  String? validateHolidayPay(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterHolidayPay;
    } else {
      return null;
    }
  }
}
