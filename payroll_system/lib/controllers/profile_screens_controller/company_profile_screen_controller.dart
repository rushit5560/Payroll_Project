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
import '../../models/company_manage_screen_model/get_all_department_model.dart';
import '../../models/success_models/success_model.dart';
import '../../models/user_profile_model/company_profile_model.dart';

class CompanyProfileScreenController extends GetxController {
  RxInt companyId = 0.obs;
  RxInt userid = 0.obs;

  // String companyName = "";

  RxBool isLoading = false.obs;

  File? imageFile;

  CompanyData? companyData;

  List<DepartmentData> departmentList = [];
  DepartmentData? departmentData;
  List<String> departmentStringList = [];

  RxList<String> selectedDepartmentList = RxList<String>([]);
  List<String> selectedDepartmentIdList = [];
  UserPreference userPreference = UserPreference();

  // List<String> selectedDepartmentList = [];
  // RxString selectedDepartmentOption = "".obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  loadUI() {
    isLoading(true);
    isLoading(false);
  }

  getCompanyIdIdFunctionFromPrefs() async {
    isLoading(true);
    int userIdPrefs = await userPreference.getIntValueFromPrefs(
        keyId: UserPreference.userIdKey);

    userid.value = userIdPrefs;

    log('Home Screen Init userid : ${userid.value}');
    await getAllDepartmentFunction(userid);
    isLoading(false);
  }

  Future<void> getAllDepartmentFunction(companyId) async {
    isLoading(true);
    String url = "${ApiUrl.getCompanyDepartmentApi}$companyId";
    log('Get All Department Api Url :$url');

    try {
      http.Response response = await http.get(Uri.parse(url));

      AllDepartmentModel allDepartmentModel =
          AllDepartmentModel.fromJson(json.decode(response.body));
      var isSuccessStatus = allDepartmentModel.success.obs;
      log("getAllDepartmentFunction hhhhhh:  ${response.body}");

      if (isSuccessStatus.value) {
        departmentList.clear();
        departmentList.addAll(allDepartmentModel.data);
        departmentStringList.clear();
        for (int i = 0; i < departmentList.length; i++) {
          departmentStringList.add(departmentList[i].departmentName);
          log('${departmentList[i].id} : ${departmentList[i].departmentName}');
        }

        log('departmentList Length : ${departmentList.length}');
      } else {
        log('getAllDepartmentFunction Else');
      }
    } catch (e) {
      log('getAllDepartmentFunction Error :$e');
      rethrow;
    } finally {
      // isLoading(false);
      getUserProfileFunction();
    }
  }

  Future<void> getUserProfileFunction() async {
    isLoading(true);
    String url = "${ApiUrl.profileGetApi}/${userid.value}";
    log("getUserProfileFunction Api url : $url");

    try {
      http.Response response = await http.get(Uri.parse(url));

      log("getUserProfileFunction response :  ${response.body}");

      CompanyProfileModel companyProfileModel =
          CompanyProfileModel.fromJson(json.decode(response.body));
      var isSuccessStatus = companyProfileModel.success;

      if (isSuccessStatus) {
        if (companyProfileModel.companyData == null) {
          log("data is empty");
        } else {
          companyData = companyProfileModel.companyData;

          nameController.text = companyData!.userName;
          phoneNumberController.text = companyData!.phoneno;
          addressController.text = companyData!.address;

          if (companyData!.departmentId != "") {
            var companyIdsString = companyData!.departmentId;

            List<int> idList = companyIdsString.split(",").map(
              (num) {
                return int.tryParse(num)!;
              },
            ).toList();

            for (int i = 0; i < idList.length; i++) {
              selectedDepartmentIdList.add(idList[i].toString());
              for (int j = 0; j < departmentList.length; j++) {
                if (idList[i] == departmentList[j].id) {
                  log("idList.length :: ${idList.length}");
                  log("departmentList.length :: ${departmentList.length}");
                  isLoading(true);
                  departmentData = departmentList[i];
                }
              }
            }
            log("departmentData!.departmentName is :: ${departmentData!.departmentName.toString()}");
          }
        }
        isLoading(false);
      } else {
        log("else case");
        isLoading(false);
      }
    } catch (e) {
      log("getUserProfileFunction error  $e");
      rethrow;
    } finally {
      // getAllDepartmentFunction();
      // isLoading(false);
    }
  }

  updateCompanyProfileFunction() async {
    isLoading(true);

    String url = ApiUrl.companyProfileUpdateApi;
    log("updateCompanyProfileFunction url: $url");

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

        request.fields['userid'] = "${userid.value}";
        request.fields['user_name'] = nameController.text;
        request.fields['phoneno'] = phoneNumberController.text;
        request.fields['address'] = addressController.text;
        request.fields['department_id'] = "${departmentData!.id}";

        request.fields['showimg'] =
            companyData!.photo.isEmpty ? "" : companyData!.photo;

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

        request.fields['userid'] = "${userid.value}";
        request.fields['user_name'] = nameController.text;
        request.fields['phoneno'] = phoneNumberController.text;
        request.fields['address'] = addressController.text;

        request.fields['department_id'] = "${departmentData!.id}";
        request.fields['showimg'] =
            companyData!.photo.isEmpty ? "" : companyData!.photo;

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
      log("updateCompanyProfileFunction Error ::: $e");
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
    getCompanyIdIdFunctionFromPrefs();
    // getAllDepartmentFunction(companyId);
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
