import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:payroll_system/models/user_permission_model/update_permission_model.dart';
import 'package:payroll_system/models/user_permission_model/user_permission_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';

class AdminPermissionScreenController extends GetxController {
  String roleId = Get.arguments[0];

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  UserPreference userPreference = UserPreference();

  /// Admin Permission Variable
  RxBool subAdminIsViewChecked = false.obs;
  RxBool subAdminIsAddChecked = false.obs;
  RxBool subAdminIsEditChecked = false.obs;
  RxBool subAdminIsDeleteChecked = false.obs;

  RxBool companyInIsViewChecked = false.obs;
  RxBool companyInIsAddChecked = false.obs;
  RxBool companyInIsEditChecked = false.obs;
  RxBool companyIsDeleteChecked = false.obs;

  RxBool departmentInIsViewChecked = false.obs;
  RxBool departmentInIsAddChecked = false.obs;
  RxBool departmentInIsEditChecked = false.obs;
  RxBool departmentIsDeleteChecked = false.obs;

  RxBool locationInIsViewChecked = false.obs;
  RxBool locationInIsAddChecked = false.obs;
  RxBool locationInIsEditChecked = false.obs;
  RxBool locationIsDeleteChecked = false.obs;

  RxBool employeeInIsViewChecked = false.obs;
  RxBool employeeInIsAddChecked = false.obs;
  RxBool employeeInIsEditChecked = false.obs;
  RxBool employeeIsDeleteChecked = false.obs;

  RxBool employeeDocumentIsViewChecked = false.obs;
  RxBool employeeDocumentIsAddChecked = false.obs;
  RxBool employeeDocumentIsEditChecked = false.obs;
  RxBool employeeDocumentIsDeleteChecked = false.obs;
  RxBool employeeDocumentIsDownloadChecked = false.obs;

  RxBool companyPayChecksIsViewChecked = false.obs;
  RxBool companyPayChecksIsAddChecked = false.obs;
  RxBool companyPayChecksIsEditChecked = false.obs;
  RxBool companyPayChecksIsDeleteChecked = false.obs;
  RxBool companyPayChecksIsDownloadChecked = false.obs;

  RxBool approvePayChecksIsViewChecked = false.obs;
  RxBool approvePayChecksIsAddChecked = false.obs;
  RxBool approvePayChecksIsEditChecked = false.obs;
  RxBool approvePayChecksIsDeleteChecked = false.obs;

  RxBool emailTemplateIsViewChecked = false.obs;
  RxBool emailTemplateIsAddChecked = false.obs;
  RxBool emailTemplateIsEditChecked = false.obs;

  RxBool roleIsViewChecked = false.obs;
  RxBool roleIsEditChecked = false.obs;

  RxBool generalSettingViewChecked = false.obs;
  RxBool generalSettingEditChecked = false.obs;



  Future<void> getUserPermissionsFunction({required String roleId}) async {
    isLoading(true);
    String url = "${ApiUrl.getPermissionApi}$roleId";
    log("getUserPermissionsFunction Api url1212 : $url");

    try {
      http.Response response = await http.get(Uri.parse(url));
      log("getUserPermissionsFunction response :  ${response.body}");

      UserPermissionModel userPermissionModel =
      UserPermissionModel.fromJson(json.decode(response.body));
      isSuccessStatus = userPermissionModel.success.obs;

      if (isSuccessStatus.value) {
        log("getUserPermissionsFunction isSuccessStatus :  ${isSuccessStatus.value}");

        await userPreference.setAllPermissionIntoPrefs(
          subAdminView: userPermissionModel.data.subadminview == "on" ? true : false,
          subAdminAdd: roleId == "1" ? true : false,
          subAdminEdit: userPermissionModel.data.subadminedit == "on" ? true : false,
          subAdminDelete: false,

          companyView: roleId == "1" ? true : false,
          companyAdd: userPermissionModel.data.companyadd == "on" ? true : false,
          companyEdit: userPermissionModel.data.companyedit == "on" ? true : false,
          companyDelete: false,

          departmentView: userPermissionModel.data.departmentview == "on" ? true : false,
          departmentAdd: userPermissionModel.data.departmentadd == "on" ? true : false,
          departmentEdit: userPermissionModel.data.departmentedit == "on" ? true : false,
          departmentDelete: userPermissionModel.data.departmentdelete == "on" ? true : false,

          locationView: userPermissionModel.data.locationview == "on" ? true : false,
          locationAdd: userPermissionModel.data.locationadd == "on" ? true : false,
          locationEdit: userPermissionModel.data.locationedit == "on" ? true : false,
          locationDelete: userPermissionModel.data.locationdelete == "on" ? true : false,

          employeeView: userPermissionModel.data.employeeview == "on" ? true : false,
          employeeAdd: userPermissionModel.data.employeeadd == "on" ? true : false,
          employeeEdit: userPermissionModel.data.employeeedit == "on" ? true : false,
          employeeDelete: userPermissionModel.data.employeedelete == "on" ? true : false,

          employeeDocumentView: userPermissionModel.data.employeedocumentview == "on" ? true : false,
          employeeDocumentAdd: userPermissionModel.data.employeedocumentadd == "on" ? true : false,
          employeeDocumentEdit: false,
          employeeDocumentDelete: userPermissionModel.data.employeedocumentdelete == "on" ? true : false,
          employeeDocumentDownload: userPermissionModel.data.employeedocumentdownload == "on" ? true : false,

          payChecksView: userPermissionModel.data.payrollview == "on" ? true : false,
          payChecksAdd: userPermissionModel.data.payrolladd == "on" ? true : false,
          payChecksEdit: false,
          payChecksDelete: false,
          payChecksDownload: userPermissionModel.data.payrolldownload == "on" ? true : false,

          approvePayChecksView: userPermissionModel.data.approvepaychecksview == "on" ? true : false,
          approvePayChecksAdd: false,
          approvePayChecksEdit: userPermissionModel.data.approvepaychecksedit == "on" ? true : false,
          approvePayChecksDelete: userPermissionModel.data.approvepaychecksdelete == "on" ? true : false,

          emailTemplateView: userPermissionModel.data.emailtemplateview == "on" ? true : false,
          emailTemplateAdd: userPermissionModel.data.emailtemplateadd == "on" ? true : false,
          emailTemplateEdit: userPermissionModel.data.emailtemplateedit == "on" ? true : false,

          roleView: roleId == "1" ? true : false,
          roleEdit: roleId == "1" ? true : false,

          generalSettingView: userPermissionModel.data.generalsettingview == "on" ? true : false,
          generalSettingEdit: userPermissionModel.data.generalsettingedit == "on" ? true : false,
        );

        subAdminIsViewChecked.value = userPermissionModel.data.subadminview == "on" ? true : false;
        subAdminIsAddChecked.value = true;
        subAdminIsEditChecked.value = userPermissionModel.data.subadminedit == "on" ? true : false;
        subAdminIsDeleteChecked.value = false;

        companyInIsViewChecked.value = true;
        companyInIsAddChecked.value = userPermissionModel.data.companyadd  == "on" ? true : false;
        companyInIsEditChecked.value = userPermissionModel.data.companyedit  == "on" ? true : false;
        companyIsDeleteChecked.value = false;

        departmentInIsViewChecked.value = userPermissionModel.data.departmentview  == "on" ? true : false;
        departmentInIsAddChecked.value = userPermissionModel.data.departmentadd  == "on" ? true : false;
        departmentInIsEditChecked.value = userPermissionModel.data.departmentedit  == "on" ? true : false;
        departmentIsDeleteChecked.value = userPermissionModel.data.departmentdelete  == "on" ? true : false;

        locationInIsViewChecked.value = userPermissionModel.data.locationview  == "on" ? true : false;
        locationInIsAddChecked.value = userPermissionModel.data.locationadd  == "on" ? true : false;
        locationInIsEditChecked.value = userPermissionModel.data.locationedit  == "on" ? true : false;
        locationIsDeleteChecked.value = userPermissionModel.data.locationdelete  == "on" ? true : false;

        employeeInIsViewChecked.value = userPermissionModel.data.employeeview  == "on" ? true : false;
        employeeInIsAddChecked.value = userPermissionModel.data.employeeadd  == "on" ? true : false;
        employeeInIsEditChecked.value = userPermissionModel.data.employeeedit  == "on" ? true : false;
        employeeIsDeleteChecked.value = userPermissionModel.data.employeedelete  == "on" ? true : false;

        employeeDocumentIsViewChecked.value = userPermissionModel.data.employeedocumentview  == "on" ? true : false;
        employeeDocumentIsAddChecked.value = userPermissionModel.data.employeedocumentadd  == "on" ? true : false;
        employeeDocumentIsEditChecked.value = false;
        employeeDocumentIsDeleteChecked.value = userPermissionModel.data.employeedocumentdelete  == "on" ? true : false;
        employeeDocumentIsDownloadChecked.value = userPermissionModel.data.employeedocumentdownload  == "on" ? true : false;

        companyPayChecksIsViewChecked.value = userPermissionModel.data.payrollview  == "on" ? true : false;
        companyPayChecksIsAddChecked.value = userPermissionModel.data.payrolladd  == "on" ? true : false;
        companyPayChecksIsEditChecked.value = false;
        companyPayChecksIsDeleteChecked.value = false;
        companyPayChecksIsDownloadChecked.value = userPermissionModel.data.payrolldownload  == "on" ? true : false;

        approvePayChecksIsViewChecked.value = userPermissionModel.data.approvepaychecksview  == "on" ? true : false;
        approvePayChecksIsAddChecked.value = false;
        approvePayChecksIsEditChecked.value = userPermissionModel.data.approvepaychecksedit  == "on" ? true : false;
        approvePayChecksIsDeleteChecked.value = userPermissionModel.data.approvepaychecksdelete  == "on" ? true : false;

        emailTemplateIsViewChecked.value = userPermissionModel.data.emailtemplateview  == "on" ? true : false;
        emailTemplateIsAddChecked.value = userPermissionModel.data.emailtemplateadd  == "on" ? true : false;
        emailTemplateIsEditChecked.value = userPermissionModel.data.emailtemplateedit  == "on" ? true : false;

        roleIsViewChecked.value = true;
        roleIsEditChecked.value = true;

        generalSettingViewChecked.value = userPermissionModel.data.generalsettingview == "on" ? true : false;
        generalSettingEditChecked.value = userPermissionModel.data.generalsettingedit == "on" ? true : false;

      } else {
        log('getUserPermissionsFunction Else');
      }
    } catch(e) {
      log("getUserPermissionsFunction error : $e");
      rethrow;
    }


    isLoading(false);
  }

  Future<void> saveUserPermissionFunction() async {
    // isLoading(true);
    String url = ApiUrl.savePermissionApi;
    log('saveUserPermissionFunction Api Url : $url');

    try {

      int userId = await userPreference.getIntValueFromPrefs(keyId: UserPreference.userIdKey);

      Map<String, dynamic> data = getData();
      // log('data : $data');

      Map<String, dynamic> bodyData = {
        "role" : roleId,
        "userid" : "$userId",
        "data" : jsonEncode(data)
      };
      log('bodyData : $bodyData');

      http.Response response = await http.post(Uri.parse(url), body: bodyData);
      log("response : ${response.body}");

      UpdatePermissionModel updatePermissionModel = UpdatePermissionModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = updatePermissionModel.success;

      if(isSuccessStatus.value) {
        Fluttertoast.showToast(msg: updatePermissionModel.messege);
        await getUserPermissionsFunction(roleId: roleId);
        Get.back();
      } else {
        log('saveUserPermissionFunction Else');
      }

    } catch(e) {
      log('saveUserPermissionFunction Error :$e');
      rethrow;
    }
    // isLoading(false);
  }

  Map<String, dynamic> getData() {
    Map<String, dynamic> data = {};

    if(subAdminIsViewChecked.value == true) {data.addAll({"subadminview" : "on"});}
    // if(subAdminIsAddChecked.value == true){}
    if(subAdminIsEditChecked.value == true){data.addAll({"subadminedit" : "on"});}
    // if(subAdminIsDeleteChecked.value == true){}
    if(companyInIsAddChecked.value == true){data.addAll({"companyadd" : "on"});}
    if(companyInIsEditChecked.value == true){data.addAll({"companyedit" : "on"});}
    if(departmentInIsViewChecked.value == true){data.addAll({"departmentview" : "on"});}
    if(departmentInIsAddChecked.value == true){data.addAll({"departmentadd" : "on"});}
    if(departmentInIsEditChecked.value == true){data.addAll({"departmentedit" : "on"});}
    if(departmentIsDeleteChecked.value == true){data.addAll({"departmentdelete" : "on"});}

    if(locationInIsViewChecked.value == true){data.addAll({"locationview" : "on"});}
    if(locationInIsAddChecked.value == true){data.addAll({"locationadd" : "on"});}
    if(locationInIsEditChecked.value == true){data.addAll({"locationedit" : "on"});}
    if(locationIsDeleteChecked.value == true){data.addAll({"locationdelete" : "on"});}

    if(employeeInIsViewChecked.value == true){data.addAll({"employeeview" : "on"});}
    if(employeeInIsAddChecked.value == true){data.addAll({"employeeadd" : "on"});}
    if(employeeInIsEditChecked.value == true){data.addAll({"employeeedit" : "on"});}
    if(employeeIsDeleteChecked.value == true){data.addAll({"employeedelete" : "on"});}

    if(employeeDocumentIsViewChecked.value == true){data.addAll({"employeedocumentview" : "on"});}
    if(employeeDocumentIsAddChecked.value == true){data.addAll({"employeedocumentadd" : "on"});}
    // if(employeeInIsEditChecked.value == true){}
    if(employeeDocumentIsDeleteChecked.value == true){data.addAll({"employeedocumentdelete" : "on"});}
    if(employeeDocumentIsDownloadChecked.value == true){data.addAll({"employeedocumentdownload" : "on"});}

    if(companyPayChecksIsViewChecked.value == true){data.addAll({"payrollview" : "on"});}
    if(companyPayChecksIsAddChecked.value == true){data.addAll({"payrolladd" : "on"});}
    if(companyPayChecksIsDownloadChecked.value == true){data.addAll({"payrolldownload" : "on"});}

    if(approvePayChecksIsViewChecked.value == true){data.addAll({"approvepaychecksview" : "on"});}
    if(approvePayChecksIsEditChecked.value == true){data.addAll({"approvepaychecksedit" : "on"});}
    if(approvePayChecksIsDeleteChecked.value == true){data.addAll({"approvepaychecksdelete" : "on"});}

    if(emailTemplateIsViewChecked.value == true){data.addAll({"emailtemplateview" : "on"});}
    if(emailTemplateIsAddChecked.value == true){data.addAll({"emailtemplateadd" : "on"});}
    if(emailTemplateIsEditChecked.value == true){data.addAll({"emailtemplateedit" : "on"});}

    if(generalSettingViewChecked.value == true){data.addAll({"generalsettingview" : "on"});}
    if(generalSettingEditChecked.value == true){data.addAll({"generalsettingedit" : "on"});}

    return data;
  }

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  initMethod() async {
    log('roleId : $roleId');
    await getUserPermissionsFunction(roleId: roleId);
  }

  loadUI() {
    isLoading(true);
    isLoading(false);
  }

}
