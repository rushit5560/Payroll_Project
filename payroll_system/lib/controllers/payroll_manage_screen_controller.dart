import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/models/company_list_screen_model/get_all_company_model.dart';
import 'package:payroll_system/models/employee_list_screen_models/employee_list_model.dart';
import 'package:payroll_system/utils/api_url.dart';

class PayRollManageScreenController extends GetxController {
  PayrollOption payrollOption = Get.arguments[0];

  String companyId = Get.arguments[1];
  String companyName = Get.arguments[2];
  // int companyId = 0;
  // String companyName = "";
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  RxString selectedValue = "Choose Option".obs;

  List<String> isPayperList = ["Choose Option", "Salary", "Hourly"];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController hourlyRateController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  DateTime birthDate = DateTime.now();
  // var dateRange = DateTimeRange(
  //         start: DateTime.now(),
  //         end: DateTime(DateTime.now().year, DateTime.now().month,
  //             DateTime.now().day + 6))
  //     .obs;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime payDate = DateTime.now();

  List<CompanyData> allCompanyList = [];
  CompanyData? companyDDSelectedItem;
  List<String> companyStringList = [];
  String companyDDSelectedStringItem = '';

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController payDateController = TextEditingController();

  TextEditingController overTimeController = TextEditingController();
  TextEditingController bonusController = TextEditingController();
  TextEditingController otherEarningController = TextEditingController();
  TextEditingController comissionController = TextEditingController();

  //getCompanyWiseEmployeeFunction
  List<CopanyWiseDepartmentData> allCompanyWiseEmployeeList = [];
  CopanyWiseDepartmentData? copanyWiseDepartmentData;
  // List<CompanyDepartmentData> companyDepartment = [];

  List<String> departmentStringList = [];

  Future<void> getCompanyWiseEmployeeFunction(companyId) async {
    isLoading(true);
    String url = "${ApiUrl.getCompanyWiseEmployeeApi}$companyId";
    log('Get All Company List Api Url :$url');
    try {
      http.Response response = await http.get(Uri.parse(url));

      CompanyWiseEmployeeModel companyWiseEmployeeModel =
          CompanyWiseEmployeeModel.fromJson(json.decode(response.body));
      isSuccessStatus = companyWiseEmployeeModel.success.obs;
      log("getCompanyWiseEmployeeFunction ${response.body}");
      if (isSuccessStatus.value) {
        allCompanyWiseEmployeeList.clear();
        allCompanyWiseEmployeeList.addAll(companyWiseEmployeeModel.data);
        for (int i = 0; i < allCompanyWiseEmployeeList.length; i++) {
          departmentStringList.add(allCompanyWiseEmployeeList[i].firstName);
        }
        allCompanyWiseEmployeeList = companyWiseEmployeeModel.data;
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

  @override
  void onInit() {
    // companyDDSelectedStringItem = companyName;
    // getAllCompanyFunction();

    getCompanyWiseEmployeeFunction(companyId);
    super.onInit();
  }

  // @override
  // void onClose() {
  //   chooseDateRangePicker() async {
  //     DateTimeRange? picked = await showDateRangePicker(
  //       context: Get.context!,
  //       firstDate: DateTime(DateTime.now().year - 20),
  //       lastDate: DateTime(DateTime.now().year + 20),
  //       initialDateRange: dateRange.value
  //     );
  //     if(picked!=null&& picked!=dateRange.value)
  //     {
  //       dateRange.value=picked;
  //     }
  //   }

  //   super.onClose();
  // }

}
