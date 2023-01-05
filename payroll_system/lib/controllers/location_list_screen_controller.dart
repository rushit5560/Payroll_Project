import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:payroll_system/models/location_list_screen_model/location_list_screen_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import '../models/location_manage_screen_model/location_delete_screen_model.dart';

class LocationListScreenController extends GetxController {
  int companyId = 0;
  String companyName = "";
  final TextEditingController textSearchEditingController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  List<LocationListData> allLocationList = [];
  List<LocationListData> searchLocationDataList = [];

  /// Company wise location
  Future<void> getCompanyWiseLocationFunction() async {
    isLoading(true);
    String url = "${ApiUrl.companyWiseLocationApi}$companyId";
    log('Company Wise Location Api Url : $url');

    try {
      http.Response response = await http.get(Uri.parse(url));

      AllLocationListModel allLocationListModel =
          AllLocationListModel.fromJson(json.decode(response.body));
      isSuccessStatus = allLocationListModel.success.obs;
      // log('response : ${response.body}');

      if (isSuccessStatus.value) {
        allLocationList = allLocationListModel.data;

        searchLocationDataList = allLocationList;
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

  /// Delete location
  Future<void> deleteLocationFunction(String locationId, int index) async {
    isLoading(true);
    String url = "${ApiUrl.deleteLocationApi}$locationId/$companyId";
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

  @override
  void onInit() {
    getCompanyWiseLocationFunction();
    super.onInit();
  }
}
