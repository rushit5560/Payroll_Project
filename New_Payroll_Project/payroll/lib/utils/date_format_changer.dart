import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:payroll/utils/extension_methods/user_preference.dart';

class DateFormater {

  String changeDateFormat(DateTime date, String prefsDateFormat) {
    String formatedDate = '';
    // log('date :$date');
    // log('prefsDateFormat :$prefsDateFormat');
    // DateTime date = DateTime.now();
    // UserPreference userPreference = UserPreference();
    // String prefsDateFormat = await userPreference.getStringValueFromPrefs(keyId: UserPreference.dateFormatKey);
    // String prefsDateFormat = dateFormat;

    if(prefsDateFormat == "m-d-Y") {
      // formatedDate = "${date.month}-${date.day}-${date.year}";
      formatedDate = DateFormat("MM-dd-yyyy").format(date);
    }
    else if(prefsDateFormat == "d-m-Y") {
      formatedDate = "${date.day}-${date.month}-${date.year}";
    }
    else if(prefsDateFormat == "Y-m-d") {
      formatedDate = "${date.year}-${date.month}-${date.day}";
    }
    else if(prefsDateFormat == "m/d/Y") {
      formatedDate = "${date.month}/${date.day}/${date.year}";
    }
    else if(prefsDateFormat == "Y/m/d") {
      formatedDate = "${date.year}/${date.month}/${date.day}";
    }
    else if(prefsDateFormat == "Y-M-d") {
      String d = DateFormat("yyyy-MMM-dd").format(date);
      formatedDate = d;
    }
    else if(prefsDateFormat == "M-d-Y") {
      String d = DateFormat("MMM-dd-yyyy").format(date);
      formatedDate = d;
    }
    else if(prefsDateFormat == "d-M-Y") {
      String d = DateFormat("dd-MMM-yyyy").format(date);
      formatedDate = d;
    }

    // log('formatedDate : $formatedDate');
    // formatedDate = "${date.month}-${date.day}-${date.year}";
    return formatedDate;
  }
}