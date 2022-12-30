import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/models/company_manage_screen_model/get_all_department_model.dart';
import 'package:payroll_system/models/employee_manage_screen_models/employee_delete_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DepartmentListScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  List<DepartmentData> allDepartmentList = [];

  int roleId = 0;
  int userId = 0;

  /// Get All Department
  Future<void> getAllDepartmentFunction() async {
    isLoading(true);
    String url = ApiUrl.allDepartmentApi;
    log('Get All Department Api Url :$url');

    try {
      http.Response response = await http.get(Uri.parse(url));

      AllDepartmentModel allDepartmentModel =
          AllDepartmentModel.fromJson(json.decode(response.body));
      isSuccessStatus = allDepartmentModel.success.obs;

      if (isSuccessStatus.value) {
        allDepartmentList.clear();
        allDepartmentList.addAll(allDepartmentModel.data);

        log('departmentList Length : ${allDepartmentList.length}');
      } else {
        log('getAllDepartmentFunction Else');
      }
    } catch (e) {
      log('getAllDepartmentFunction Error :$e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  /// Delete Department
  Future<void> deleteDepartmentFunction(String departmentId, int index) async {
    isLoading(true);
    String url = "${ApiUrl.deleteDepartmentApi}$departmentId";
    log('Delete Department Api Url :$url');

    try {
      http.Response response = await http.get(Uri.parse(url));
      log('response : ${response.body}');

      EmployeeDeleteModel deleteCompanyModel =
          EmployeeDeleteModel.fromJson(json.decode(response.body));
      isSuccessStatus = deleteCompanyModel.success.obs;

      if (isSuccessStatus.value) {
        Fluttertoast.showToast(msg: deleteCompanyModel.messege);
        // deleteEmployeeFunction(employeeId, index);
        allDepartmentList.removeAt(index);
        Get.back();
      } else {
        log('deleteDepartmentFunction Else');
      }
    } catch (e) {
      log('deleteDepartmentFunction Error :$e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> getCompanyWiseDepartmentFunction() async {
    isLoading(true);
    String url = ApiUrl.getCompanyDepartmentApi;
    log('Get Company Department Api Url :$url');

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['id'] = "$userId";

      var response = await request.send();

      response.stream
          .transform(const Utf8Decoder())
          .transform(const LineSplitter())
          .listen((value) {
        AllDepartmentModel companyDepartmentModel =
            AllDepartmentModel.fromJson(json.decode(value));
        isSuccessStatus = companyDepartmentModel.success.obs;

        if (isSuccessStatus.value) {
          allDepartmentList.clear();
          allDepartmentList.addAll(companyDepartmentModel.data);

          log('allDepartmentList : ${allDepartmentList.length}');
        } else {
          log('getAllCompanyFunction Else');
        }
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong !");

      rethrow;
    } finally {
      isLoading(false);
    }
  }

  getUserIdDataFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    roleId = prefs.getInt(UserPreference.roleIdKey) ?? 0;
    userId = prefs.getInt(UserPreference.userIdKey) ?? 0;

    log('Department List Screen OnInit Role Id : $roleId');
    log('Department List Screen OnInit user Id : $userId');
    if (roleId == 1 || roleId == 2) {
      await getAllDepartmentFunction();
    } else if (roleId == 3) {
      await getCompanyWiseDepartmentFunction();
    }

    log('asasas');
  }

  @override
  void onInit() {
    getUserIdDataFromPrefs();
    /*log('Department List Screen OnInit Role Id : ${UserDetails.roleId}');
    if(UserDetails.roleId == 1 || UserDetails.roleId == 1) {
      getAllDepartmentFunction();
    } else  if(UserDetails.roleId == 3){
      getCompanyWiseDepartmentFunction();
    }*/
    super.onInit();
  }
}
