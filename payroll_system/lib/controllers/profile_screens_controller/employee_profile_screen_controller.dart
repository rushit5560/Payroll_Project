import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:payroll_system/models/user_profile_model/employee_profile_model.dart';
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

  EmployeeDatum? employeeData;

  List<DepartmentData> departmentList = [];
  List<String> departmentStringList = [];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  File? imageFile;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dobFieldController = TextEditingController();
  TextEditingController homeNumberController = TextEditingController();
  TextEditingController workNumberController = TextEditingController();

  TextEditingController currentAddressController = TextEditingController();
  TextEditingController homeAddressController = TextEditingController();

  Future<void> selectDateOfBirth(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (d != null) {
      isLoading(true);
      dobFieldController.text = "${d.year}-${d.month}-${d.day}";
      isLoading(false);
    }
  }

  Future<void> getEmployeeProfileFunction() async {
    isLoading(true);

    var userId = await UserPreference()
        .getIntValueFromPrefs(keyId: UserPreference.userIdKey);
    String url = "${ApiUrl.employeeProfileGetApi}$userId";
    log("getEmployeeProfileFunction Api url : $url");

    try {
      http.Response response = await http.get(Uri.parse(url));

      log("getEmployeeProfileFunction response :  ${response.body}");

      EmployeeProfileModel employeeProfileModel =
          EmployeeProfileModel.fromJson(json.decode(response.body));
      var isSuccessStatus = employeeProfileModel.success;

      if (isSuccessStatus) {
        if (employeeProfileModel.data.isEmpty) {
          log("data is empty");
        } else {
          employeeData = employeeProfileModel.data[0];

          firstNameController.text = employeeData!.firstName;
          middleNameController.text = employeeData!.middleName;
          lastNameController.text = employeeData!.lastName;

          phoneNumberController.text = employeeData!.phoneNo;

          if (employeeData!.dateOfBrith != "") {
            dobFieldController.text = employeeData!.dateOfBrith.split(" ")[0];
          } else {
            dobFieldController.text = employeeData!.dateOfBrith;
          }

          homeNumberController.text = employeeData!.homeNo;
          workNumberController.text = employeeData!.workPhone;

          homeAddressController.text = employeeData!.home;
          currentAddressController.text = employeeData!.address;
        }

        log(" get employee details success :: ");
      } else {
        log("else case");
      }
    } catch (e) {
      log("getEmployeeProfileFunction error  $e");
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  updateEmployeeProfileFunction() async {
    isLoading(true);

    String url = ApiUrl.employeeProfileUpdateApi;
    log("updateEmployeeProfileFunction url: $url");

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
        request.fields['first_name'] = firstNameController.text;
        request.fields['middle_name'] = middleNameController.text;
        request.fields['last_name'] = lastNameController.text;

        request.fields['phone_no'] = phoneNumberController.text;
        request.fields['date_of_brith'] = dobFieldController.text;
        request.fields['address'] = currentAddressController.text;
        request.fields['home'] = homeAddressController.text;
        request.fields['home_no'] = dobFieldController.text;
        request.fields['work_phone'] = dobFieldController.text;

        request.fields['showimg'] =
            employeeData!.photo.isEmpty ? "" : employeeData!.photo;

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

            // prefs.setString(UserPreference.userNameKey, nameController.text);

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
        request.fields['first_name'] = firstNameController.text;
        request.fields['middle_name'] = middleNameController.text;
        request.fields['last_name'] = lastNameController.text;

        request.fields['phone_no'] = phoneNumberController.text;
        request.fields['date_of_brith'] = dobFieldController.text;
        request.fields['address'] = currentAddressController.text;
        request.fields['home'] = homeAddressController.text;
        request.fields['home_no'] = dobFieldController.text;
        request.fields['work_phone'] = dobFieldController.text;

        request.fields['showimg'] =
            employeeData!.photo.isEmpty ? "" : employeeData!.photo;

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

            // prefs.setString(UserPreference.userNameKey, nameController.text);

            UserDetails.userName =
                prefs.getString(UserPreference.userNameKey) ?? "";

            Get.back();
          } else {
            log('False False');
          }
        });
      }
    } catch (e) {
      log("updateEmployeeProfileFunction Error ::: $e");
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

    getEmployeeProfileFunction();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
