import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:payroll_system/Models/company_list_screen_model/get_all_company_model.dart';
import 'package:payroll_system/Utils/api_url.dart';

class CompanyListScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  List<CompanyData> allCompanyList = [];


  Future<void> getAllCompanyFunction() async {
    isLoading(true);
    String url = ApiUrl.allCompanyApi;
    log('Get All Company List Api Url :$url');

    try {
      http.Response response = await http.get(Uri.parse(url));

      AllCompanyModel allCompanyModel = AllCompanyModel.fromJson(json.decode(response.body));
      isSuccessStatus = allCompanyModel.success.obs;

      if(isSuccessStatus.value) {
        allCompanyList.clear();
        allCompanyList.addAll(allCompanyModel.data);
        log('allCompanyList Length : ${allCompanyList.length}');

      } else {
        log('getAllCompanyFunction Else');
      }




    } catch(e) {
      log('getAllCompanyFunction Error :$e');
      rethrow;
    } finally {
      isLoading(false);
    }

  }



  @override
  void onInit() {
    getAllCompanyFunction();
    super.onInit();
  }

}