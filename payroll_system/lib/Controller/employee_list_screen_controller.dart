import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../Models/employee_list_model/employee_list_model.dart';
import '../Utils/api_url.dart';
import 'package:http/http.dart' as http;

class EmployeeListScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  List<EmployeeData> allCompanyList = [];

  Future<void> getAllEmployeeFunction() async {
    isLoading(true);
    String url = ApiUrl.allEmployee;
    log('Get All Company List Api Url :$url');

    try {
      http.Response response = await http.get(Uri.parse(url));

      EmployeeModele allCompanyModel =
          EmployeeModele.fromJson(json.decode(response.body));
      isSuccessStatus = allCompanyModel.success.obs;

      if (isSuccessStatus.value) {
        allCompanyList.clear();
        allCompanyList.addAll(allCompanyModel.data);
        log('allCompanyList Length : ${allCompanyList.length}');
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
    getAllEmployeeFunction();
    // TODO: implement onInit
    super.onInit();
  }
}
