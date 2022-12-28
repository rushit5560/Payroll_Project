class FieldValidation {
  String? validateUserName(String value) {
    if (value.isEmpty) {
      return 'Please enter your name';
    } else {
      return null;
    }
  }

  String? validateFirstName(String value) {
    if (value.isEmpty) {
      return 'Please enter your first name';
    } else {
      return null;
    }
  }

  String? validateMiddleName(String value) {
    if (value.isEmpty) {
      return 'Please enter your middle name';
    } else {
      return null;
    }
  }

  String? validateCurrentPassword(String value) {
    if (value.isEmpty) {
      return 'Please enter your current password';
    } else {
      return null;
    }
  }

  String? validateLastName(String value) {
    if (value.isEmpty) {
      return 'Please enter your last name';
    } else {
      return null;
    }
  }

  String? validateMobileNumber(String value) {
    if (value.isEmpty) {
      return 'Please enter your mobile number';
    } else if (value.length < 10) {
      return 'Mobile number must enter 10 characters';
    } else if (value.length > 10) {
      return 'Mobile number enter 10 characters';
    } else {
      return null;
    }
  }

  String? validateCurrentAddress(String value) {
    if (value.isEmpty) {
      return 'Please enter your currentAddress';
    } else {
      return null;
    }
  }

  String? validateCompanyAddress(String value) {
    if (value.isEmpty) {
      return 'Please enter your company Address';
    } else {
      return null;
    }
  }

  //location
  String? validateLocationName(String value) {
    if (value.isEmpty) {
      return 'Please enter your first name';
    } else {
      return null;
    }

  }

  String? validateAddress(String value) {
    if (value.isEmpty) {
      return 'Please enter your address';
    } else {
      return null;
    }
  }

  String? validateHomeAddress(String value) {
    if (value.isEmpty) {
      return 'Please enter your home address';
    } else {
      return null;
    }
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return "Email address is required";
    } else if (!isNumeric(value) &&
        !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
      return "Invalid email address";
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
      return 'Please enter department Id';
    } else {
      return null;
    }
  }

  String? validateCompanyId(String value) {
    if (value.isEmpty) {
      return 'Please enter company Id';
    } else {
      return null;
    }
  }

  String? validateCompanyName(String value) {
    if (value.isEmpty) {
      return 'Please enter company name';
    } else {
      return null;
    }
  }

  String? validateDepartmentName(String value) {
    if (value.isEmpty) {
      return 'Please enter department name';
    } else {
      return null;
    }
  }

  String? validateHomePhoneNumber(String value) {
    if (value.isEmpty) {
      return 'Please enter phoneNumber';
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
    if (value.isEmpty) {
      return 'Please enter your phone number';
    } else {
      return null;
    }
  }

  String? validateDateOfBirth(String value) {
    if (value.isEmpty) {
      return 'Please enter your date of brith';
    } else {
      return null;
    }
  }

  String? validateHourlyRate(String value) {
    if (value.isEmpty) {
      return 'Please enter hourlyRate';
    } else {
      return null;
    }
  }

  String? validateSalary(String value) {
    if (value.isEmpty) {
      return 'Please enter salary';
    } else {
      return null;
    }
  }

  String? validateStartDayWork(String value) {
    if (value.isEmpty) {
      return 'Please enter firstDayWork';
    } else {
      return null;
    }
  }

  String? validateLastDayWork(String value) {
    if (value.isEmpty) {
      return 'Please enter lastDayWork';
    } else {
      return null;
    }
  }

  String? validateZipCode(String value) {
    if (value.isEmpty) {
      return 'Please enter zipCode';
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Password is required";
    } else if (value.length < 8) {
      return "Password must be at least 8 characters long";
    } else {
      return null;
    }
  }


  String? validateConfirmPassword(String value, String passwordValue) {
    if (value.isEmpty) {
      return "Confirm Password is required";
    } else if (value.length < 8) {
      return "Confirm Password must be at least 8 characters long";
    } else if (value != passwordValue) {
      return "Password & confirm password mus be same";
    } else {
      return null;
    }
  }
}
