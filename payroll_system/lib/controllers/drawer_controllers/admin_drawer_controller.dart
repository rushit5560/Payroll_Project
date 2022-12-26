import 'dart:convert';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/models/user_permission_model/user_permission_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:payroll_system/utils/extension_methods/user_details.dart';
import 'package:http/http.dart' as http;
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
class AdminDrawerController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  //User getUserPermissionsFunction
  /*Future<void> getUserPermissionsFunction() async {
    isLoading(true);
    String url = "${ApiUrl.getPermissionApi}${UserDetails.userId.toString()}";
    log("getUserPermissionsFunction Api url1212 : $url");

    try {
      http.Response response = await http.get(
        Uri.parse(url),
      );

      log("getUserPermissionsFunction response :  ${response.body}");

      UserPermissionModel userPermissionModel =
      UserPermissionModel.fromJson(json.decode(response.body));
      isSuccessStatus = userPermissionModel.success.obs;

      if (isSuccessStatus.value) {
        log("getUserPermissionsFunction isSuccessStatus :  ${isSuccessStatus.value}");

        // Fluttertoast.showToast(msg: userPermissionModel.messege);

        UserPreference().setUserPermissionsToPrefsAndLocal(
          // role
          roleAdd: userPermissionModel.data.roleadd == "on" ? true : false,
          roleEdit: userPermissionModel.data.roleedit == "on" ? true : false,
          roleView: userPermissionModel.data.roleview == "on" ? true : false,
          roleDelete:
          userPermissionModel.data.roledelete == "on" ? true : false,
          //company
          companyAdd:
          userPermissionModel.data.companyadd == "on" ? true : false,
          companyEdit:
          userPermissionModel.data.companyedit == "on" ? true : false,
          companyView:
          userPermissionModel.data.companyview == "on" ? true : false,
          companyDelete:
          userPermissionModel.data.companydelete == "on" ? true : false,
          //location
          locationAdd:
          userPermissionModel.data.locationadd == "on" ? true : false,
          locationEdit:
          userPermissionModel.data.locationedit == "on" ? true : false,
          locationView:
          userPermissionModel.data.locationview == "on" ? true : false,
          locationDelete:
          userPermissionModel.data.locationdelete == "on" ? true : false,
          //employee
          employeeAdd:
          userPermissionModel.data.employeeadd == "on" ? true : false,
          employeeEdit:
          userPermissionModel.data.employeeedit == "on" ? true : false,
          employeeView:
          userPermissionModel.data.employeeview == "on" ? true : false,
          employeeDelete:
          userPermissionModel.data.employeedelete == "on" ? true : false,
          //department
          departmentAdd:
          userPermissionModel.data.departmentadd == "on" ? true : false,
          departmentEdit:
          userPermissionModel.data.departmentedit == "on" ? true : false,
          departmentView:
          userPermissionModel.data.departmentview == "on" ? true : false,
          departmentDelete:
          userPermissionModel.data.departmentdelete == "on" ? true : false,
        );

        // Fluttertoast.showToast(msg: 'You are successfully login');
      } else {
        Fluttertoast.showToast(msg: 'user permissions not found');
      }
    } catch (e) {
      log("getUserPermissionsFunction error : $e");
    } finally {
      isLoading(false);
    }
  }*/

  @override
  void onInit() {
    log('UserDetails.companyView onInit : ${UserDetails.companyView}');
    isLoading(true);
    isLoading(false);
    // getUserPermissionsFunction();
    super.onInit();
  }
}