import 'package:get/get.dart';

class SubAdminPermissionScreenController extends GetxController {


  RxBool companyInIsViewChecked = false.obs;
  RxBool companyInIsAddChecked = false.obs;
  RxBool companyInIsEditChecked = false.obs;
  RxBool companyIsDeleteChecked = false.obs;

  RxBool departmentInIsViewChecked = false.obs;
  RxBool departmentInIsAddChecked = false.obs;
  RxBool departmentInIsEditChecked = false.obs;
  RxBool departmentIsDeleteChecked = false.obs;

  RxBool employeeInIsViewChecked = false.obs;
  RxBool employeeInIsAddChecked = false.obs;
  RxBool employeeInIsEditChecked = false.obs;
  RxBool employeeIsDeleteChecked = false.obs;

  RxBool locationInIsViewChecked = false.obs;
  RxBool locationInIsAddChecked = false.obs;
  RxBool locationInIsEditChecked = false.obs;
  RxBool locationIsDeleteChecked = false.obs;



  RxBool payrollInIsViewChecked = false.obs;
  RxBool payrollInIsAddChecked = false.obs;
  RxBool payrollInIsEditChecked = false.obs;
  RxBool payrollIsDeleteChecked = false.obs;
}
