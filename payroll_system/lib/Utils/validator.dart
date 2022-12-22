class FieldValidation {
  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Please enter User name';
    } else {
      return null;
    }
  }

  String? validateFullName(String value) {
    if (value.isEmpty) {
      return 'Please enter Full Name';
    } else {
      return null;
    }
  }

  String? validateLastName(String value) {
    if (value.isEmpty) {
      return 'Please enter name';
    } else {
      return null;
    }
  }

  String? validateAddress(String value) {
    if (value.isEmpty) {
      return 'Please enter address';
    } else {
      return null;
    }
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return "Email Address is required";
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
      return 'Please enter Department Id';
    } else {
      return null;
    }
  }

  String? validateCompanyId(String value) {
    if (value.isEmpty) {
      return 'Please enter Company Id';
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

  String? validateHomePhoneNumber(String value) {
    if (value.isEmpty) {
      return 'Please enter PhoneNumber';
    } else {
      return null;
    }
  }

  String? validateWorkPhoneNumber(String value) {
    if (value.isEmpty) {
      return 'Please enter Phone number';
    } else {
      return null;
    }
  }

  String? validateDAteOfBirth(String value) {
    if (value.isEmpty) {
      return 'Please enter dateofbrith';
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
      return 'Please enter Salary';
    } else {
      return null;
    }
  }

  String? validateFirstDayWork(String value) {
    if (value.isEmpty) {
      return 'Please enter FirstDayWork';
    } else {
      return null;
    }
  }

  String? validateZipCode(String value) {
    if (value.isEmpty) {
      return 'Please enter ZipCode';
    } else {
      return null;
    }
  }

  String? validateMobileNumber(String value) {
    if (value.isEmpty) {
      return 'Please enter Mobile number';
    } else if (value.length < 10) {
      return 'Phone number must enter 10 characters';
    } else if (value.length > 10) {
      return 'Phone number enter 10 characters';
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Password is required";
    } else if (value.length < 6) {
      return "Password must be at least 6 characters long";
    } else {
      return null;
    }
  }
}
