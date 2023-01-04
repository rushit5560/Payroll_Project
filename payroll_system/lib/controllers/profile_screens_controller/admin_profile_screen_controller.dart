import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/api_url.dart';
import '../../Utils/extension_methods/user_details.dart';
import '../../models/log_in_model.dart';
import '../../models/success_models/success_model.dart';
import '../../models/user_profile_model/user_profile_model.dart';

class AdminProfileScreenController extends GetxController {
  RxBool isLoading = false.obs;

  File? imageFile;

  UserData? profileData;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();

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
        if (userProfileModel.data == null) {
          log("data is empty");
        } else {
          profileData = userProfileModel.data;

          userNameController.text = profileData!.userName;
        }

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

  updateAdminProfileFunction() async {
    isLoading(true);

    String url = ApiUrl.adminProfileUpdateApi;
    log("updateUserProfileFunction url: $url");

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

        request.fields['userid'] = UserDetails.userId.toString();
        request.fields['user_name'] = userNameController.text;

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

            prefs.setString(
                UserPreference.userNameKey, userNameController.text);

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
        request.fields['user_name'] = userNameController.text;
        // request.fields['photo'] = "";
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

            prefs.setString(
                UserPreference.userNameKey, userNameController.text);

            UserDetails.userName =
                prefs.getString(UserPreference.userNameKey) ?? "";

            Get.back();
          } else {
            log('False False');
          }
        });
      }
    } catch (e) {
      log("updateUserProfileFunction Error ::: $e");
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  imageFromCamera() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    if (image != null) {
      isLoading(true);
      imageFile = File(image.path);
      isLoading(false);
    }

    Get.back();
  }

  imageFromGallary() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      isLoading(true);
      imageFile = File(image.path);
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
                    imageFromGallary();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Camera"),
                  onTap: () {
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
