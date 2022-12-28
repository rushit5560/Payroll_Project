import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:payroll_system/Utils/api_url.dart';
import 'package:payroll_system/models/location_list_screen_model/location_list_screen_model.dart';

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
  }
}
