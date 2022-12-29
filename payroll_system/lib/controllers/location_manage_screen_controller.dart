import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:http/http.dart' as http;
import 'package:payroll_system/controllers/location_list_screen_controller.dart';
import 'package:payroll_system/models/location_manage_screen_model/location_create_model.dart';
import 'package:payroll_system/models/location_manage_screen_model/location_get_by_id_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import '../Utils/extension_methods/user_details.dart';
import '../models/location_manage_screen_model/location_update_model.dart';

class LocationManageScreenController extends GetxController {
  final allLocationListScreenController =
      Get.find<LocationListScreenController>();

  RxBool isLoading = false.obs;
  String getLocationId = Get.arguments[1] ?? "";
  RxBool isSuccessStatus = false.obs;

  LocationOption locationOption = Get.arguments[0];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController locationNameController = TextEditingController();
  List<String> isActiveOptionList = ["Choose Option", "active", "inactive"];
  RxString selectedValue = "Choose Option".obs;

  Future<void> locationCreateFunction() async {
    isLoading(true);
    String url = ApiUrl.createLocationApi;

    log(url);
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['location_name'] = locationNameController.text.trim();
      request.fields['is_active'] = selectedValue.value == "active" ? "1" : "0";
      request.fields['userid'] = "${UserDetails.userId}";

      var response = await request.send();
      response.stream
          .transform(const Utf8Decoder())
          .transform(const LineSplitter())
          .listen((value) async {
        log('value : $value');
        LocationCreateModel locationCreateModel =
            LocationCreateModel.fromJson(json.decode(value.toString()));
        isSuccessStatus = locationCreateModel.success.obs;
        if (isSuccessStatus.value) {
          Fluttertoast.showToast(msg: locationCreateModel.messege);
          Get.back();

          await allLocationListScreenController.getAlllocationListFunction();
        } else {
          log('locationCreateFunction Else');
          if (locationCreateModel.error.locationName
              .toString()
              .contains("The location name has already been taken")) {
            Fluttertoast.showToast(
                msg: locationCreateModel.error.locationName[0].toString());
          }
        }
        log("Empliyee Details : $locationCreateModel");
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong !");
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> locationGetByIdFunction() async {
    isLoading(true);
    String url = "${ApiUrl.getLocationApi}$getLocationId";
    log("Get Location url::   $url");
    try {
      http.Response response = await http.get(Uri.parse(url));

      LocationGetByIdModel locationGetByIdModel = LocationGetByIdModel.fromJson(
        json.decode(response.body),
      );
      isSuccessStatus = locationGetByIdModel.success.obs;
      if (isSuccessStatus.value) {
        locationNameController.text = locationGetByIdModel.data.locationName;

        selectedValue.value =
            locationGetByIdModel.data.isActive == "1" ? "active" : "inactive";
      } else {
        log("locationGetByIdFunction else");
      }
    } catch (e) {
      log("locationGetByIdFunction error $e");
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> locationUpdateFunction() async {
    isLoading(true);

    String url = ApiUrl.updateLocationApi;

    log("Location Update Url::$url");

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields['location_name'] = locationNameController.text.trim();
      request.fields['is_active'] = selectedValue.value == "active" ? "1" : "0";
      request.fields['id'] = getLocationId;
      request.fields['userid'] = "${UserDetails.userId}";

      var response = await request.send();
      response.stream
          .transform(const Utf8Decoder())
          .transform(const LineSplitter())
          .listen((value) async {
        log('value Updateemployee : $value');
        LocationUpdateModel locationUpdateModel =
            LocationUpdateModel.fromJson(json.decode(value));

        isSuccessStatus = locationUpdateModel.success.obs;
        if (isSuccessStatus.value) {
          Fluttertoast.showToast(msg: locationUpdateModel.messege);
          Get.back();
          await allLocationListScreenController.getAlllocationListFunction();
        } else {
          log("locationUpdateFunction Else");
        }
        log("Location update : $locationUpdateModel");
      });
    } catch (e) {
      log('updateLocationFunction Error :$e');

      rethrow;
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    locationGetByIdFunction();
    // TODO: implement onInit
    super.onInit();
  }
}
