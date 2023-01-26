import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/controllers/sub_admin_list_screen_controller.dart';
import 'package:payroll_system/models/sub_admin_manage_screen_model/sub_admin_getbyid_screen_model.dart';
import 'package:payroll_system/models/sub_admin_manage_screen_model/sub_admin_update_screen_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:payroll_system/utils/extension_methods/user_details.dart';

class SubAdminManageScreenController extends GetxController {
  String getSubadminId = Get.arguments[0] ?? "";

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController townAddressController = TextEditingController();
  TextEditingController stateAddressController = TextEditingController();
  TextEditingController cityAddressController = TextEditingController();
  TextEditingController zipcodeAddressController = TextEditingController();

  final subAdminListScreenController = Get.find<SubAdminListScreenController>();

  Future<void> subadminGetByIdFunction() async {
    isLoading(true);
    String url = "${ApiUrl.getSubAdminApi}$getSubadminId";
    log("Get subadmin url::   $url");
    try {
      http.Response response = await http.get(Uri.parse(url));

      SubAdminGetByIdModel subAdminGetByIdModel = SubAdminGetByIdModel.fromJson(
        json.decode(response.body),
      );

      isSuccessStatus = subAdminGetByIdModel.success.obs;

      if (isSuccessStatus.value) {
        firstNameController.text = subAdminGetByIdModel.data.userName;
        emailController.text = subAdminGetByIdModel.data.email;
        phoneNoController.text = subAdminGetByIdModel.data.phoneno;
        streetAddressController.text = subAdminGetByIdModel.data.street;
        townAddressController.text = subAdminGetByIdModel.data.town;
        stateAddressController.text = subAdminGetByIdModel.data.state;
        cityAddressController.text = subAdminGetByIdModel.data.city;
        zipcodeAddressController.text = subAdminGetByIdModel.data.zipcode;
      } else {}

      log("subadminGetByIdFunction : ${response.body}");
      isSuccessStatus = subAdminGetByIdModel.success.obs;
    } catch (e) {
      log("subadminGetByIdFunction error $e");
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> subAdminUpdateFunction() async {
    isLoading(true);

    String url = ApiUrl.updateSubAdminApi;

    log("subAdminUpdateFunction Update Url::$url");

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['id'] = getSubadminId;
      request.fields['userid'] = "${UserDetails.userId}";
      request.fields['user_name'] = firstNameController.text.trim();
      request.fields['email'] = emailController.text.trim();
      request.fields['phoneno'] = phoneNoController.text.trim();
      request.fields['street'] = streetAddressController.text.trim();
      request.fields['town'] = townAddressController.text.trim();
      request.fields['state'] = stateAddressController.text.trim();
      request.fields['city'] = cityAddressController.text.trim();
      request.fields['zipcode'] = zipcodeAddressController.text.trim();

      var response = await request.send();
      response.stream
          .transform(const Utf8Decoder())
          .transform(const LineSplitter())
          .listen((value) async {
        log('value subAdminUpdateFunction : $value');
        SubAdminUpdateModel subAdminUpdateModel =
            SubAdminUpdateModel.fromJson(json.decode(value));

        isSuccessStatus = subAdminUpdateModel.success.obs;
        if (isSuccessStatus.value) {
          Fluttertoast.showToast(msg: subAdminUpdateModel.messege);
          Get.back();
          await subAdminListScreenController.getAllSubAdminListFunction();
        } else {
          log("subAdminUpdateFunction Else");
        }
        log("subAdminUpdateFunction update : $subAdminUpdateModel");
      });
    } catch (e) {
      log('subAdminUpdateFunction Error :$e');

      rethrow;
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    subadminGetByIdFunction();
    super.onInit();
  }
}
