import 'package:payroll/utils/messaging.dart';

class FieldValidation {
  String? validateUserName(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterName;
    } else {
      return null;
    }
  }

  String? validateFirstName(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterFirstName;
    } else {
      return null;
    }
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterName;
    } else {
      return null;
    }
  }

  String? validateMiddleName(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterMiddleName;
    } else {
      return null;
    }
  }

  String? validateCurrentPassword(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterCurrentPassword;
    } else {
      return null;
    }
  }

  String? validateLastName(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterLastName;
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
      return AppMessage.pleaseEnterCurrentAddress;
    } else {
      return null;
    }
  }

  String? validateZipcode(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterZipcode;
    } else {
      return null;
    }
  }

  String? validateText(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterText;
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
      return AppMessage.pleaseEnterCompanyAddress;
    } else {
      return null;
    }
  }

  //location
  String? validateLocationName(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterLocation;
    } else {
      return null;
    }
  }

  String? validateAddress(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterAddress;
    } else {
      return null;
    }
  }

  String? validateHomeAddress(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterHomeAddress;
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
      return AppMessage.pleaseEnterDateOfBirth;
    } else {
      return null;
    }
  }

  String? validateHourlyRate(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterHourlyRate;
    } else if (value == "0" || int.parse(value) < 0) {
      return AppMessage.valueGreterOne;
    }
    else {
      return null;
    }
  }

  String? validateSalary(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterSalary;
    } else if (value == "0" || int.parse(value) < 0) {
      return AppMessage.valueGreterOne;
    }else {
      return null;
    }
  }

  String? validateEmployeeStartDate(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterEmployeeStartDate;
    } else {
      return null;
    }
  }

  String? pleaseEnterEmployeeEndDate(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterEmployeeEndDate;
    } else {
      return null;
    }
  }

  String? validateLastDayWork(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterEmployeeEndDate;
    } else {
      return null;
    }
  }

  String? validateZipCode(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterZipCode;
    } else if (value.length < 5) {
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

  String? validateOldPassword(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterOldPassword;
    } else if (value.length < 8) {
      return AppMessage.passwordMustBeAtleast8CharactersLong;
    } else {
      return null;
    }
  }

  String? validateNewPassword(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterNewPassword;
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

  String? validateEndDate(String value, DateTime endTime) {
    DateTime d = DateTime.now();

    if (value.isEmpty) {
      return AppMessage.pleaseEnterEndDate;
    } else if (endTime.compareTo(d) > 0) {
      return "The end date must be a date before ${d.year}-${d.month}-${d.day}.";
    } else {
      return null;
    }
  }

  String? validatePayDate(String value, DateTime endTime, DateTime payDate) {
    // DateTime d = DateTime.now();

    if (value.isEmpty) {
      return AppMessage.pleaseEnterPayDate;
    } else if (payDate.compareTo(endTime) < 0) {
      return "The pay date must be a date after ${endTime.year}-${endTime.month}-${endTime.day}.";
    } else {
      return null;
    }
  }

  String? validateRegularRate(String value) {
    if (value.isEmpty) {
      return AppMessage.pleaseEnterRegularRate;
    } else if (value == "0" || int.parse(value) < 0) {
      return AppMessage.valueGreterOne;
    }
    // 0// }
    else {
      return null;
    }
  }

  String? validateOt(String value) {
    if (value.isEmpty) {
      return null;
    } else if (int.parse(value) < 0) {
      return AppMessage.valueGreterZero;
    } else {
      return null;
    }
  }

  String? validateHolidayPay(String value) {
    if (value.isEmpty) {
      return null;
    } else if (int.parse(value) < 0) {
      return AppMessage.valueGreterZero;
    } else {
      return null;
    }
  }

  String? validateBonusPay(String value) {
    if (value.isEmpty) {
      return null;
    } else if (int.parse(value) < 0) {
      return AppMessage.valueGreterZero;
    } else {
      return null;
    }
  }

  String? validateOtherEarningPay(String value) {
    if (value.isEmpty) {
      return null;
    } else if (int.parse(value) < 0) {
      return AppMessage.valueGreterZero;
    } else {
      return null;
    }
  }

  String? validateDropdownStatus(String value) {
    if (value == AppMessage.chooseOption) {
      return AppMessage.activeStatusMessage;
    } else {
      return null;
    }
  }

  String? validateDropdownDateFormat(String value) {
    if (value == AppMessage.chooseOption) {
      return AppMessage.pleaseSelectDateFormat;
    } else {
      return null;
    }
  }

  String? validateDropdownPayPeriod(String value) {
    if (value == AppMessage.chooseOption) {
      return AppMessage.pleaseSelectPayPeriodValidate;
    } else {
      return null;
    }
  }

  String? validateDropdownCompany(String value) {
    if (value == AppMessage.chooseOption) {
      return AppMessage.pleaseSelectCompanyValidate;
    } else {
      return null;
    }
  }

  String? validateDropdownDepartment(String value) {
    if (value == AppMessage.chooseOption) {
      return AppMessage.pleaseSelectDepartmentValidate;
    } else {
      return null;
    }
  }

  String? validateDropdownLocation(String value) {
    if (value == AppMessage.chooseOption) {
      return AppMessage.pleaseSelectLocationValidate;
    } else {
      return null;
    }
  }
}
