import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:payroll_system/models/employee_list_screen_models/employee_list_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';

class CompanyHomeScreenController extends GetxController {
  // String companyId = Get.arguments[0];
  // String companyName = Get.arguments[1];
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  List<CopanyWiseDepartmentData> allCompanyWiseEmployeeList = [];
  int companyId = 0;
  String companyName = "";

  UserPreference userPreference = UserPreference();

  // Get All Employee
  Future<void> getCompanyWiseEmployeeFunction() async {
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

  getLoggedInUserDataFromPrefs() async {
    companyId = await userPreference.getIntValueFromPrefs(
        keyId: UserPreference.userIdKey);
    await getCompanyWiseEmployeeFunction();
  }

  @override
  void onInit() {
    getLoggedInUserDataFromPrefs();
    super.onInit();
  }
}
