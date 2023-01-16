import 'package:get/get.dart';

class ApprovePaychecksListScreenController extends GetxController {
  String companyId = Get.arguments[0];
  String companyName = Get.arguments[1];

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  List approvePaychecksList = [];
}