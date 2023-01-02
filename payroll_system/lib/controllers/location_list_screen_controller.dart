import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:payroll_system/models/location_list_screen_model/location_list_screen_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import '../models/location_manage_screen_model/location_delete_screen_model.dart';

class LocationListScreenController extends GetxController {
  String companyId = Get.arguments[0];
  String companyName = Get.arguments[1];

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  List<LocationListData> allLocationList = [];

  /// Company wise location
  Future<void> getCompanyWiseLocationFunction(companyId) async {
    isLoading(true);
    String url = "${ApiUrl.companyWiseLocationApi}$companyId";
    log('Company Wise Location Api Url : $url');

    try {
      http.Response response = await http.get(Uri.parse(url));
      log('response : ${response.body}');

      AllLocationListModel allLocationListModel =
          AllLocationListModel.fromJson(json.decode(response.body));
      isSuccessStatus = allLocationListModel.success.obs;

      if (isSuccessStatus.value) {
        allLocationList = allLocationListModel.data;

        // Fluttertoast.showToast(msg: allLocationListModel.messege);
        // allLocationList.removeAt(index);
      } else {
        log('deleteCompanyFunction Else');
      }
    } catch (e) {
      log('deleteCompanyFunction Error :$e');
      rethrow;
    } finally {
      isLoading(false);
    }

    // try {
    //   var request = http.MultipartRequest('POST', Uri.parse(url));
    //   request.fields['id'] = companyId;

    //   var response = await request.send();

    //   response.stream
    //       .transform(const Utf8Decoder())
    //       .transform(const LineSplitter())
    //       .listen((value) {
    //     AllLocationListModel allLocationListModel =
    //         AllLocationListModel.fromJson(json.decode(value));

    //     if (isSuccessStatus.value) {
    //       allLocationList.clear();
    //       allLocationList.addAll(allLocationListModel.data);

    //       log('allDepartmentList : ${allLocationList.length}');
    //     } else {
    //       log('getAllCompanyFunction Else');
    //       log(value);
    //     }
    //   });
    // } catch (e) {
    //   log('getCompanyWiseLocation Error :$e');
    //   rethrow;
    // } finally {
    //   isLoading(false);
    // }
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
    getCompanyWiseLocationFunction(companyId);
    super.onInit();
  }

  /// Get All Location
  /*Future<void> getAllLocationListFunction() async {
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
        log('allLocationList : ${allLocationList.length}');
      } else {
        log("Get All Location....");
      }
    } catch (e) {
      log('getAllLocationListFunction Error : $e');
      rethrow;
    } finally {
      isLoading(false);
    }
    // isLoading(false);
  }*/
}
