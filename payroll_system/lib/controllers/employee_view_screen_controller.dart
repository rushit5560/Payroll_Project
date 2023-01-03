import 'package:get/get.dart';

class EmployeeViewScreenController extends GetxController {
  final String companyId = Get.arguments[0];
  final String companyName = Get.arguments[1];

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
}
