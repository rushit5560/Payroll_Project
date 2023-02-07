import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:payroll_system/models/employee_list_screen_models/employee_list_model.dart';
import 'package:payroll_system/models/pay_checkes_manage_screen_model/paychecks_create_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';

import 'pay_checkes_list_screen_controller.dart';

class PayCheckedManageScreenController extends GetxController {
  // PayrollOption payrollOption = Get.arguments[0];
  String companyId = Get.arguments[0];
  String companyName = Get.arguments[1];

  // int companyId = 0;
  // String companyName = "";
  int userIdPrefs = 0;
  RxBool isPrivacyChecked = false.obs;

  // int companyId = 0;
  // String companyName = "";
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  RxString selectedCheckedValue = "Choose Option".obs;

  List<String> isPayCheckedList = [
    "Choose Option",
    "Weekly",
    "Bi-Weekly",
    "Others"
  ];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> employeeFormKey = GlobalKey<FormState>();

  DateTime birthDate = DateTime.now();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime payDate = DateTime.now().subtract(const Duration(days: 1));

  // CompanyData? companyDDSelectedItem;
  List<String> companyStringList = [];
  String companyDDSelectedStringItem = '';
  UserPreference userPreference = UserPreference();

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController payDateController = TextEditingController();

  TextEditingController overTimeController = TextEditingController();
  TextEditingController bonusController = TextEditingController();
  TextEditingController otherEarningController = TextEditingController();
  TextEditingController comissionController = TextEditingController();
  TextEditingController weeklyRateController = TextEditingController();
  TextEditingController byWeeklyController = TextEditingController();
  TextEditingController otherRateController = TextEditingController();
  TextEditingController regularController = TextEditingController();

  TextEditingController holidayPayController = TextEditingController();
  TextEditingController sickPayHoursController = TextEditingController();
  TextEditingController vacationHourController = TextEditingController();
  TextEditingController tipController = TextEditingController();
  TextEditingController taxController = TextEditingController();
  TextEditingController memoController = TextEditingController();

  List<String> regularHoursList = [];
  List<String> overTimeList = [];
  List<String> holidayPayList = [];
  List<String> bonusList = [];
  List<String> otherEarningList = [];
  List<String> commissionList = [];
  List<String> sickPayList = [];
  List<String> vacationHoursList = [];
  List<String> tipList = [];
  List<String> taxList = [];
  List<String> selectedEmployeeList = [];

  List<Map<String, dynamic>> data = [];

  clearAllTextFieldsList() {
    regularHoursList.clear();
    overTimeList.clear();
    holidayPayList.clear();
    bonusList.clear();
    otherEarningList.clear();
    commissionList.clear();
    sickPayList.clear();
    vacationHoursList.clear();
    tipList.clear();
    taxList.clear();
    selectedEmployeeList.clear();
  }

  final payCheckesListScreenController = Get.find<PayCheckesListScreenController>();

  //getCompanyWiseEmployeeFunction
  List<CompanyWiseEmployeeData> allCompanyWiseEmployeeList = [];
  // CompanyWiseEmployeeData? companyWiseDepartmentData;
  // List<CompanyDepartmentData> companyDepartment = [];

  List<String> departmentStringList = [];

  Future<void> getPaycheckWiseEmployeeFunction() async {
    isLoading(true);
    String url = ApiUrl.payCheckWiseEmployeeApi;
    log('Get All Company List Api Url :$url');
    int userId = await userPreference.getIntValueFromPrefs(keyId: UserPreference.userIdKey);

    try {
      Map<String, dynamic> bodyData = {
        "userid": "$userId",
        "cid": companyId,
        "pay_period": "hourly"
      };

      http.Response response = await http.post(Uri.parse(url),body: bodyData);

      CompanyWiseEmployeeModel companyWiseEmployeeModel =
          CompanyWiseEmployeeModel.fromJson(json.decode(response.body));
      isSuccessStatus = companyWiseEmployeeModel.success.obs;
      log("getCompanyWiseEmployeeFunction ${response.body}");
      if (isSuccessStatus.value) {
        allCompanyWiseEmployeeList.clear();
        for(int i=0; i < companyWiseEmployeeModel.data.length; i++) {
          if(companyWiseEmployeeModel.data[i].isActive == "1") {
            allCompanyWiseEmployeeList.add(companyWiseEmployeeModel.data[i]);
          }
        }
        // allCompanyWiseEmployeeList.addAll(companyWiseEmployeeModel.data);
        // for (int i = 0; i < allCompanyWiseEmployeeList.length; i++) {
        //   departmentStringList.add(allCompanyWiseEmployeeList[i].firstName);
        // }
      } else {
        log('getAllCompanyFunction Else');
      }
    } catch (e) {
      log('getAllCompanyFunction Error :$e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  // Future<void> getCreatePayrollFunction() async {
  //   isLoading(true);
  //   String url = ApiUrl.createPayrollApi;
  //   try {
  //     var request = http.MultipartRequest('POST', Uri.parse(url));
  //     request.fields['startdate'] = startDateController.text.trim();
  //     request.fields['enddate'] = endDateController.text.trim();
  //     request.fields['regularhour'] = regularHourController.text.trim();
  //     request.fields['salary'] = salaryController.text.trim();
  //     request.fields['overtime'] = overTimeController.text.trim();
  //     request.fields['bonus'] = bonusController.text.trim();
  //     request.fields['otherearning'] = otherEarningController.text.trim();
  //     request.fields['commission'] = comissionController.text.trim();
  //     request.fields['paydate'] = payDateController.text.trim();
  //     request.fields['pay_period'] =
  //         selectedValuePayper.value == "Salary" ? "salary" : "hourly";
  //     request.fields['userid'] = "$userIdPrefs";
  //     request.fields['cid'] = companyId.toString();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<void> createPaycheckFunction() async {
    isLoading(true);
    String url = ApiUrl.createPayCheckesApi;
    log('createPaycheckFunction Api Url :$url');

    int userId = await userPreference.getIntValueFromPrefs(keyId: UserPreference.userIdKey);
    int daysCount = endDate.difference(startDate).inDays;

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields['cid'] = companyId;
      request.fields['userid'] = "$userId";
      request.fields['typeid'] = selectedCheckedValue.value.toLowerCase();
      request.fields['startdate'] = startDateController.text.trim();
      request.fields['enddate'] = endDateController.text.trim();
      request.fields['paydate'] = payDateController.text.trim();
      request.fields['days'] = "$daysCount";
      request.fields['memo'] = memoController.text.trim();
      request.fields['data'] = jsonEncode(data);
      // request.fields['employee'] = selectedEmployeeList.toString().replaceAll(" ", "");
      // request.fields['regularhour'] = regularHoursList.toString().replaceAll(" ", "");
      // request.fields['overtime'] = overTimeList.toString().replaceAll(" ", "");
      // request.fields['holidaypay'] = holidayPayList.toString().replaceAll(" ", "");
      // request.fields['bonus'] = bonusList.toString().replaceAll(" ", "");
      // request.fields['otherearning'] = otherEarningList.toString().replaceAll(" ", "");
      // request.fields['commission'] = commissionList.toString().replaceAll(" ", "");
      // request.fields['sickpay'] = sickPayList.toString().replaceAll(" ", "");
      // request.fields['vacationhours'] = vacationHoursList.toString().replaceAll(" ", "");
      // request.fields['tip'] = tipList.toString().replaceAll(" ", "");
      // request.fields['tax'] = taxList.toString().replaceAll(" ", "");

      log('request.fields : ${request.fields}');

      var response = await request.send();

      response.stream
          .transform(const Utf8Decoder())
          .transform(const LineSplitter())
          .listen((value) async {
        log('value : $value');

        PaychecksCreateModel paychecksCreateModel =
            PaychecksCreateModel.fromJson(json.decode(value));
        isSuccessStatus.value = paychecksCreateModel.success;

        if (isSuccessStatus.value) {
          Fluttertoast.showToast(msg: paychecksCreateModel.messege);
          Get.back();
          await payCheckesListScreenController.getPaycheckesListFunction();
        } else {
          log('createPaycheckFunction Else');
        }
      });

      /*Map<String, dynamic> bodyData = {
        "cid": companyId,
        "userid": "$userId",
        "typeid": selectedCheckedValue.value.toLowerCase(),
        "startdate": startDateController.text.trim(),
        "enddate": endDateController.text.trim(),
        "paydate": payDateController.text.trim(),
        "regularhour": "$regularHoursList",
        "overtime": "$overTimeList",
        "holidaypay": "$holidayPayList",
        "bonus": "$bonusList",
        "otherearning": "$otherEarningList",
        "commission": "$commissionList",
        "sickpay": "$sickPayList",
        "vacationhours": "$vacationHoursList",
        "tip": "$tipList",
        "tax": "$taxList",
        "memo": memoController.text.trim(),
      };*/

    } catch (e) {
      log('createPaycheckFunction Error : $e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    // companyDDSelectedStringItem = companyName;
    // getAllCompanyFunction();
    initMethod();
    super.onInit();
  }

  initMethod() async {
    await getPaycheckWiseEmployeeFunction();
  }
}
