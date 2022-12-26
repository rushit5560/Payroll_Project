import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payroll_system/Utils/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:payroll_system/models/company_department_model/company_department_model.dart';
import 'package:payroll_system/models/employee_manage_screen_models/create_employee_model.dart';
import 'package:sizer/sizer.dart';

import '../Utils/extension_methods/user_details.dart';
import '../constants/anums.dart';
import '../models/company_list_screen_model/get_all_company_model.dart';
import '../models/company_manage_screen_model/get_all_department_model.dart';

class EmployeManageScreenController extends GetxController {
  DateTime? chosenDateTime;
  DateTime selectedDate = DateTime.now();
  EmployeeOption employeeOption = Get.arguments[0];
  RxBool isPasswordVisible = false.obs;
  List<String> isActiveOptionList = ["Choose Option", "active", "inactive"];
  RxString selectedValue = "Choose Option".obs;
  RxBool isLoading = false.obs;
  Rx<List<String>> selectedDepartmentList = Rx<List<String>>([]);
  Rx<List<String>> selectedCompanyList = Rx<List<String>>([]);

  List<String> selectedDepartmentIdList = [];
  List<String> selectedCompanyIdList = [];

  RxBool isSuccessStatus = false.obs;
  List<DepartmentData> departmentList = [];
  // List<CompanyData> companyList = [];

  List<String> departmentStringList = [];
  List<String> companyStringList = [];

  // CompanyOption companyOption = Get.arguments[0];
  List<CompanyData> allCompanyList = [];
  CompanyData? companyDDSelectedItem;
  DepartmentData? departmentDataItem;
  CompanyDepartmentData? companyDepartmentData;

  RxString selectedDepartmentOption = "".obs;
  RxString selectedCompanyOption = "".obs;
  // final employeeListScreenController = Get.find<EmployeeListScreenController>();

  RxList<String> selectedEmpDepartmentList = RxList<String>([]);
  List<String> selectedEmpDepartmentIdList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController textEditingController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  TextEditingController dateOfBrithController = TextEditingController();
  TextEditingController departmentController = TextEditingController();

  TextEditingController homeNoController = TextEditingController();
  TextEditingController workNoController = TextEditingController();
  TextEditingController hourlyRateController = TextEditingController();

  TextEditingController salaryController = TextEditingController();

  TextEditingController startDateController = TextEditingController();
  TextEditingController lastDateController = TextEditingController();

  TextEditingController isActiveController = TextEditingController();

  TextEditingController companyController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController currentAddressController = TextEditingController();
  TextEditingController homeAddressController = TextEditingController();

  File? images;

  RxBool isloding = false.obs;
  imageFromCamera() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    if (image != null) {
      isloding(true);
      images = File(image.path);
      isloding(false);
    }
  }

  imageFromGallary() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      isloding(true);

      images = File(image.path);
      isloding(false);
    }
  }

  void showPicker(BuildContext context) async {
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
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Camera"),
                  onTap: () {
                    // employeDetailsFormController.getImage(ImageSource.camera);

                    imageFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  void showDatePicker(
    ctx,
  ) {
    showCupertinoModalPopup(
      context: ctx,
      builder: (_) => Container(
        height: 40.h,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
                height: 30.h,
                child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (DateTime newdate) {
                    print(newdate);
                    isloding(true);
                    chosenDateTime = newdate;
                    isloding(false);
                  },
                  minuteInterval: 1,
                  use24hFormat: true,
                  mode: CupertinoDatePickerMode.date,
                )),
            // Close the modal
            CupertinoButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(ctx).pop(),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getAllCompanyFunction() async {
    isLoading(true);
    String url = ApiUrl.allCompanyApi;
    // log('Get All Company List Api Url :$url');

    try {
      http.Response response = await http.get(Uri.parse(url));

      AllCompanyModel allCompanyModel =
          AllCompanyModel.fromJson(json.decode(response.body));
      isSuccessStatus = allCompanyModel.success.obs;
      // log('GetAllCompany :,${response.body}');
      if (isSuccessStatus.value) {
        allCompanyList.clear();
        allCompanyList.addAll(allCompanyModel.data);

        companyDDSelectedItem = allCompanyList[0];

        log('companyDDSelectedItem : ${companyDDSelectedItem!.fullName}');

        companyStringList.clear();
        for (int i = 0; i < allCompanyList.length; i++) {
          companyStringList.add(allCompanyList[i].userName);
        }
        // log('allCompanyList Length2222 : ${allCompanyList.length}');
        // log('allCompanyList Length1111 : ${allCompanyList.length}');
      } else {
        log('getAllCompanyFunction Else');
      }
    } catch (e) {
      log('getAllCompanyFunction Error :$e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> getCompanyDepartmentFunction(int companyId) async {
    // isLoading(true);
    String url = "${ApiUrl.getCompanyDepartmentApi}";
    log('Get COmpanyDepartment Api Url :$url');

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields['id'] = "$companyId";

           var response = await request.send();


            response.stream
          .transform(const Utf8Decoder())
          .transform(const LineSplitter()).listen((value) { 

            CompanyDepartmentModel companyDepartmentModel =
            CompanyDepartmentModel.fromJson(json.decode(value));


            
          });





      // http.Response response = await http.post(Uri.parse(url), body: bodyData);
      // log("Department");
      // // log('GetAllDepartment ${response.body}');
      // CompanyDepartmentModel companyDepartmentModel =
      //     CompanyDepartmentModel.fromJson(json.decode(response.body));
      // isSuccessStatus = companyDepartmentModel.success.obs;

      // if (isSuccessStatus.value) {
      //   departmentList.clear();
      //   departmentList.addAll(companyDepartmentModel.data);

      //   departmentStringList.clear();
      //   for (int i = 0; i < departmentList.length; i++) {
      //     departmentStringList.add(departmentList[i].departmentName);
      //   }
      // } else {
      //   log('getAllDepartmentFunction Else');
      // }
    } catch (e) {
      log('getAllDepartmentFunction Error :$e');
      rethrow;
    }
    //  finally {
    //   isLoading(false);
    // }

    isLoading(true);
    isLoading(false);
  }

  Future<void> employeeCreateFunction() async {
    // log('12211');
    // log('ImAGE is :: ${images!.path} ');

    isLoading(true);
    String url = ApiUrl.createEmployeeApi;
    log(url);
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields['first_name'] = firstNameController.text.trim();
      request.fields['middle_name'] = middleNameController.text.trim();
      request.fields['last_name'] = lastNameController.text.trim();
      request.fields['password'] = passwordController.text.trim();
      request.fields['address'] = currentAddressController.text.trim();
      request.fields['phone_no'] = phoneNoController.text.trim();
      request.fields['email'] = emailController.text.trim();
      request.fields['department_id'] = "$selectedDepartmentIdList";
      request.fields['date_of_brith'] = dateOfBrithController.text.trim();
      request.fields['home'] = homeAddressController.text.trim();
      request.fields['home_no'] = homeNoController.text.trim();
      request.fields['work_phone'] = workNoController.text.trim();
      request.fields['hourly_rate'] = hourlyRateController.text.trim();
      request.fields['salary'] = salaryController.text.trim();
      request.fields['start_date'] = startDateController.text.trim();
      request.fields['last_day_of_work'] = lastDateController.text.trim();
      request.fields['companyid'] = "${companyDDSelectedItem!.id}";
      request.fields['userid'] = "${UserDetails.userId}";

      log('777');
      request.files
          .add(await http.MultipartFile.fromPath("Photo", images!.path));
      log("1232357 8");

      var response = await request.send();
      log('getEmployeeStore: $response');
      response.stream
          .transform(const Utf8Decoder())
          .transform(const LineSplitter())
          .listen((value) async {
        log("value : $value");
        log(response.stream.toString());

        CraeteEmployeeModel employeeCreateModel =
            CraeteEmployeeModel.fromJson(json.decode(value));

        isSuccessStatus = employeeCreateModel.success.obs;
        if (isSuccessStatus.value) {
          Fluttertoast.showToast(msg: employeeCreateModel.messege);

          Get.back();
          // await employeeListScreenController.getAllEmployeeFunction();
        } else {
          Fluttertoast.showToast(msg: "Something wrong!");
        }
        log("Empliyee Details : $employeeCreateModel");
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong !");
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    getAllCompanyFunction();

    super.onInit();
  }

  loadUI() {
    isLoading(true);
    isLoading(false);
  }
}
