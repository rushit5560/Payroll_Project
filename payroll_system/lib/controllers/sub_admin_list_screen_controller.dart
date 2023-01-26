import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:payroll_system/models/sub_admin_list_screen_model/sub_admin_list_screen_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:http/http.dart' as http;

class SubAdminListScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  List<SubadminListData> subadminListData = [];

  List<SubadminListData> searchSubadminDataList = [];
  final TextEditingController textSearchEditingController =
      TextEditingController();

  Future<void> getAllSubAdminListFunction() async {
    isLoading(true);
    String url = ApiUrl.allSubAdminApi;
    log('getAllSubAdminListFunction Url : $url');

    try {
      http.Response response = await http.get(Uri.parse(url));

      SubadminListModel subadminListModel =
          SubadminListModel.fromJson(json.decode(response.body));
      isSuccessStatus = subadminListModel.success.obs;
      log('getAllSubAdminListFunction response : ${response.body}');

      if (isSuccessStatus.value) {
        subadminListData = subadminListModel.data;

        searchSubadminDataList = subadminListData;
      } else {
        log('getAllSubAdminListFunction Else');
      }
    } catch (e) {
      log('getAllSubAdminListFunction Error :$e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    getAllSubAdminListFunction();
    super.onInit();
  }
}
