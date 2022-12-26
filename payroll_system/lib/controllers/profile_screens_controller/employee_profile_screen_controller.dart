import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:payroll_system/constants/anums.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/api_url.dart';
import '../../Utils/extension_methods/user_details.dart';
import '../../models/company_manage_screen_model/get_all_department_model.dart';
import '../../models/log_in_model.dart';
import '../../models/success_models/success_model.dart';
import '../../models/user_profile_model/user_profile_model.dart';

class EmployeeProfileScreenController extends GetxController {
  RxBool isLoading = false.obs;

  File? imageFile;

  UserData? profileData;

  List<DepartmentData> departmentList = [];
  List<String> departmentStringList = [];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  Future<void> getUserProfileFunction() async {
    isLoading(true);
    String url = ApiUrl.profileGetApi + "/${UserDetails.userId}";
    log("getUserProfileFunction Api url : $url");

    try {
      http.Response response = await http.get(Uri.parse(url));

      log("getUserProfileFunction response :  ${response.body}");

      UserProfileModel userProfileModel =
          UserProfileModel.fromJson(json.decode(response.body));
      var isSuccessStatus = userProfileModel.success;

      if (isSuccessStatus) {
        profileData = userProfileModel.data;

        nameController.text = profileData!.userName;
        phoneNumberController.text = profileData!.phoneno;
        addressController.text = profileData!.address;

        log(" userName :: ${userProfileModel.data.userName}");
      } else {
        log("else case");
      }
    } catch (e) {
      log("getUserProfileFunction error  $e");
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  // /// Get All Department
  // Future<void> getAllDepartmentFunction() async {
  //   isLoading(true);
  //   String url = ApiUrl.allDepartmentApi;
  //   log('Get All Department Api Url :$url');

  //   try {
  //     http.Response response = await http.get(Uri.parse(url));

  //     AllDepartmentModel allDepartmentModel =
  //         AllDepartmentModel.fromJson(json.decode(response.body));
  //     var isSuccessStatus = allDepartmentModel.success;

  //     if (isSuccessStatus) {
  //       departmentList.clear();
  //       departmentList.addAll(allDepartmentModel.data);

  //       departmentStringList.clear();
  //       for (int i = 0; i < departmentList.length; i++) {
  //         departmentStringList.add(departmentList[i].departmentName);
  //         log('${departmentList[i].id} : ${departmentList[i].departmentName}');
  //       }

  //       log('departmentList Length : ${departmentList.length}');
  //     } else {
  //       log('getAllDepartmentFunction Else');
  //     }
  //   } catch (e) {
  //     log('getAllDepartmentFunction Error :$e');
  //     rethrow;
  //   } finally {
  //     if (companyOption == CompanyOption.update) {
  //       // when update company that time
  //       await getCompanyDetailsFunction();
  //     } else if (companyOption == CompanyOption.create) {
  //       // when create new company
  //       isLoading(false);
  //     }
  //       isLoading(false);
  //   }
  // }

  updateSubAdminProfileFunction() async {
    isLoading(true);

    String url = ApiUrl.subAdminProfileUpdateApi;
    log("updateSubAdminProfileFunction url: $url");

    log('UserDetails.userid: ${UserDetails.userId}');

    try {
      if (imageFile != null) {
        log("uploading with a photo");
        var request = http.MultipartRequest('POST', Uri.parse(url));

        request.files.add(
          await http.MultipartFile.fromPath(
            "photo",
            imageFile!.path,
          ),
        );
        // request.headers.addAll(apiHeader.headers);

        request.fields['userid'] = UserDetails.userId.toString();
        request.fields['user_name'] = nameController.text;
        request.fields['phoneno'] = phoneNumberController.text;
        request.fields['address'] = addressController.text;

        request.fields['showimg'] =
            profileData!.photo.isEmpty ? "" : profileData!.photo;

        log('request.fields: ${request.fields}');
        log('request.files: ${request.files}');

        log('request.headers: ${request.headers}');

        var response = await request.send();
        log('response: ${response.request}');

        response.stream
            .transform(const Utf8Decoder())
            .transform(const LineSplitter())
            .listen((value) async {
          SuccessModel successModel = SuccessModel.fromJson(json.decode(value));
          var isSuccessStatus = successModel.success;
          log('response body is ::: $value');

          if (isSuccessStatus) {
            Fluttertoast.showToast(
              msg: "User profile update successfully.",
              toastLength: Toast.LENGTH_SHORT,
            );
            log(successModel.message);

            SharedPreferences prefs = await SharedPreferences.getInstance();

            prefs.setString(UserPreference.userNameKey, nameController.text);

            UserDetails.userName =
                prefs.getString(UserPreference.userNameKey) ?? "";

            Get.back();
          } else {
            log('False False');
          }
        });
      } else {
        log("uploading without a photo");
        var request = http.MultipartRequest('POST', Uri.parse(url));

        request.fields['userid'] = UserDetails.userId.toString();
        request.fields['user_name'] = nameController.text;
        request.fields['phoneno'] = phoneNumberController.text;
        request.fields['address'] = addressController.text;
        request.fields['showimg'] =
            profileData!.photo.isEmpty ? "" : profileData!.photo;

        log('request.fields: ${request.fields}');
        log('request.files: ${request.files}');

        log('request.headers: ${request.headers}');

        var response = await request.send();
        log('response: ${response.request}');

        response.stream
            .transform(const Utf8Decoder())
            .transform(const LineSplitter())
            .listen((value) async {
          SuccessModel successModel = SuccessModel.fromJson(json.decode(value));
          var isSuccessStatus = successModel.success;
          log('response body is ::: $value');

          if (isSuccessStatus) {
            Fluttertoast.showToast(
              msg: "User profile update successfully.",
              toastLength: Toast.LENGTH_SHORT,
            );
            log(successModel.message);

            SharedPreferences prefs = await SharedPreferences.getInstance();

            prefs.setString(UserPreference.userNameKey, nameController.text);

            UserDetails.userName =
                prefs.getString(UserPreference.userNameKey) ?? "";

            Get.back();
          } else {
            log('False False');
          }
        });
      }
    } catch (e) {
      log("updateSubAdminProfileFunction Error ::: $e");
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  imageFromCamera() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    if (image != null) {
      imageFile = File(image.path);
      isLoading(true);
      isLoading(false);
    }
    Get.back();
  }

  imageFromGallary() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      imageFile = File(image.path);
      isLoading(true);
      isLoading(false);
    }
    Get.back();
  }

  void showPhotoPickerSheet(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text("Gallery"),
                  onTap: () {
                    // employeDetailsFormController.getImage(ImageSource.gallery);

                    imageFromGallary();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Camera"),
                  onTap: () {
                    // employeDetailsFormController.getImage(ImageSource.camera);

                    imageFromCamera();
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  void onInit() {
    // TODO: implement onInit

    getUserProfileFunction();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
