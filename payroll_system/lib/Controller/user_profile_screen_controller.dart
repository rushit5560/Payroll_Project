import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../Models/log_in_model.dart';
import '../Models/success_models/success_model.dart';
import '../Models/user_profile_model/user_profile_model.dart';
import '../Utils/api_url.dart';
import '../Utils/extension_methods/user_details.dart';

class UserProfileScreenController extends GetxController {
  RxBool isLoading = false.obs;

  File? imageFile;

  UserData? profileData;

  TextEditingController userNameController = TextEditingController();

  Future<void> getUserProfileFunction() async {
    isLoading(true);
    String url = ApiUrl.profileGetApi;
    log("getUserProfileFunction Api url : $url");

    try {
      http.Response response = await http.get(Uri.parse(url));

      log("getUserProfileFunction response :  ${response.body}");

      UserProfileModel userProfileModel =
          UserProfileModel.fromJson(json.decode(response.body));
      var isSuccessStatus = userProfileModel.success;

      if (isSuccessStatus) {
        profileData = userProfileModel.data;

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

  updateUserProfileFunction() async {
    isLoading(true);

    String url = ApiUrl.profileUpdateApi;
    log("updateUserProfileFunction url: $url");

    log('UserDetails.userid: ${UserDetails.userId}');

    try {
      if (imageFile != null) {
        print("uploading with a photo");
        var request = http.MultipartRequest('POST', Uri.parse(url));

        var stream = http.ByteStream(imageFile!.openRead());
        stream.cast();

        var length = await imageFile!.length();

        request.files
            .add(await http.MultipartFile.fromPath("image", imageFile!.path));
        // request.headers.addAll(apiHeader.headers);

        request.fields['userid'] = UserDetails.userId.toString();
        request.fields['user_name'] = userNameController.text;
        request.fields['photo'] = userNameController.text;
        request.fields['showimage'] = userNameController.text;

        // var multiPart = http.MultipartFile(
        //   'photo',
        //   stream,
        //   length,
        // );

        // var multiFile = await http.MultipartFile.fromPath(
        //  "image",
        //   file!.path,
        // );

        // request.files.add(multiPart);

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
          log('response1 ::: ${isSuccessStatus}');

          if (isSuccessStatus) {
            Fluttertoast.showToast(
              msg: "User update successfully.",
              toastLength: Toast.LENGTH_SHORT,
            );
            log(successModel.message);

            Get.back();
          } else {
            log('False False');
          }
        });
      } else {
        print("uploading without a photo");
        var request = http.MultipartRequest('POST', Uri.parse(url));

        // var stream = http.ByteStream(file!.openRead());
        // stream.cast();
        //
        // var length = await file!.length();

        // request.headers.addAll(apiHeader.headers);

        // request.fields['Id'] = UserDetails.userId.toString();
        // request.fields['PhoneNo'] = mobileTextFieldController.text.trim();
        // request.fields['DateOfBirth'] = "$selectedDate";
        // request.fields['Gender'] = gender.value;
        // request.fields['ModifiedBy'] = UserDetails.uniqueId;

        // var multiPart = http.MultipartFile(
        //   'file',
        //   stream,
        //   length,
        // );
        //
        // request.files.add(multiPart);

        // log('request.fields: ${request.fields}');
        // log('request.files: ${request.files}');
        // log('request.headers: ${request.headers}');

        // var response = await request.send();
        // log('response: ${response.request}');

        // response.stream
        //     .transform(const Utf8Decoder())
        //     .transform(const LineSplitter())
        //     .listen((value) async {
        //   UpdateUserProfileModel updateUserProfileModel =
        //       UpdateUserProfileModel.fromJson(json.decode(value));
        //   log('response1 :::::: ${updateUserProfileModel.statusCode}');
        //   isSuccessStatus = updateUserProfileModel.success.obs;

        //   if (isSuccessStatus.value) {
        //     Fluttertoast.showToast(
        //         msg: "User update successfully.",
        //         toastLength: Toast.LENGTH_SHORT);
        //     log(updateUserProfileModel.dataVendor.userName);
        //     log(updateUserProfileModel.dataVendor.email);
        //     log(updateUserProfileModel.dataVendor.phoneNo);
        //     Get.back();
        //   } else {
        //     log('False False');
        //   }
        // });
      }
    } catch (e) {
      log("updateUserProfileFunction Error ::: $e");
    } finally {
      isLoading(false);
    }
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    isLoading(true);
    imageFile = File(pickedFile!.path);
    isLoading(false);

    Get.back();
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    isLoading(true);
    imageFile = File(pickedFile!.path);
    isLoading(false);

    Get.back();
  }

  Future<void> showPhotoChoiceDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Choose option",
            style: TextStyle(color: Colors.black),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                const Divider(
                  height: 1,
                  color: Colors.black,
                ),
                const SizedBox(height: 10),
                ListTile(
                  onTap: () {
                    _openGallery(context);
                  },
                  title: const Text("Gallery"),
                  leading: const Icon(
                    Icons.account_box,
                    color: Colors.black,
                  ),
                ),
                // Divider(
                //   height: 1,
                //   color: Colors.black,
                // ),
                ListTile(
                  onTap: () {
                    _openCamera(context);
                  },
                  title: const Text("Camera"),
                  leading: const Icon(
                    Icons.camera,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
