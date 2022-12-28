import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:payroll_system/Utils/api_url.dart';
import 'package:payroll_system/models/location_list_screen_model/location_list_screen_model.dart';

import '../models/location_manage_screen_model/location_delete_screeen_model.dart';

class LocationListScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  List<LocationListData> allLocationList = [];

  Future<void> locationListFunction() async {
    isLoading(true);
    String url = ApiUrl.allLocationApi;

    log('Get All Location List Api Url :$url');
    try {
      http.Response response = await http.get(Uri.parse(url));

      AllLocationListModel allLocationListModel = AllLocationListModel.fromJson(
        json.decode(response.body),
      );
      log(response.body);
      isSuccessStatus = allLocationListModel.success.obs;
      if (isSuccessStatus.value) {
        allLocationList.clear();
        allLocationList.addAll(allLocationListModel.data);
      } else {
        log("Get All Location....");
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }

    // Delete Location
    Future<void> deleteEmployeeFunction(String employeeId, int index) async {
      isLoading(true);
      String url = "${ApiUrl.deleteEmployeeApi}$employeeId";
      log('Delete Company Api Url :$url');

      try {
        http.Response response = await http.get(Uri.parse(url));
        log('response : ${response.body}');

        LocationDeleteModel locationDeleteModel =
            LocationDeleteModel.fromJson(json.decode(response.body));
        isSuccessStatus = locationDeleteModel.success.obs;

        if (isSuccessStatus.value) {
          Fluttertoast.showToast(msg: locationDeleteModel.messege);
          allLocationList.removeAt(index);
          Get.back();
        } else {
          log('deleteCompanyFunction Else');
        }
      } catch (e) {
        log('deleteCompanyFunction Error :$e');
        rethrow;
      } finally {
        isLoading(false);
      }
    }
  }

  @override
  void onInit() {
    locationListFunction();
    // TODO: implement onInit
    super.onInit();
  }
}
