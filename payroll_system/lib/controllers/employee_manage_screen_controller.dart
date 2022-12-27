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
import 'package:payroll_system/controllers/employee_list_screen_controller.dart';
import 'package:payroll_system/models/company_department_model/company_department_model.dart';
import 'package:payroll_system/models/employee_manage_screen_models/create_employee_model.dart';
import 'package:payroll_system/models/employee_manage_screen_models/update_employee_model.dart';
import 'package:sizer/sizer.dart';

import '../Utils/extension_methods/user_details.dart';
import '../constants/enums.dart';
import '../models/company_list_screen_model/get_all_company_model.dart';
import '../models/employee_manage_screen_models/employee_get_by_id_model.dart';

class EmployeManageScreenController extends GetxController {
  EmployeeOption employeeOption = Get.arguments[0];
  String employeeId = Get.arguments[1] ?? "";

  DateTime? chosenDateTime;
  DateTime selectedDate = DateTime.now();
  RxBool isPasswordVisible = true.obs;
  List<String> isActiveOptionList = ["Choose Option", "active", "inactive"];
  RxString selectedValue = "Choose Option".obs;
  RxBool isLoading = false.obs;
  RxList<String> selectedDepartmentList = RxList<String>([]);

  Rx<List<String>> selectedCompanyList = Rx<List<String>>([]);

  List<String> selectedDepartmentIdList = [];
  List<String> selectedCompanyIdList = [];
  final employeeListScreenController = Get.find<EmployeeListScreenController>();

  RxBool isSuccessStatus = false.obs;
  // List<DepartmentData> departmentList = [];
  // List<CompanyData> companyList = [];

  List<String> departmentStringList = [];
  List<String> companyStringList = [];

  int companyId = 0;
  int departmentId = 0;

  DateTime birthDate = DateTime.now();
  DateTime startDate = DateTime.now();

  // CompanyOption companyOption = Get.arguments[0];
  List<CompanyData> allCompanyList = [];
  List<CompanyDepartmentData> companyDepartment = [];

  // List<CompanyDepartmentData> allCompanyList = [];

  CompanyData? companyDDSelectedItem;
  // DepartmentData? departmentDataItem;
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
  String oldImageName = "";

  RxBool isloding = false.obs;
  imageFromCamera() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    if (image != null) {
      isloding(true);
      images = File(image.path);
      isloding(false);
    }

    Get.back();
  }

  imageFromGallary() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      isloding(true);

      images = File(image.path);
      isloding(false);
    }
    Get.back();
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
                  onTap: () async {
                    // employeDetailsFormController.getImage(ImageSource.gallery);

                    await imageFromGallary();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Camera"),
                  onTap: () async {
                    // employeDetailsFormController.getImage(ImageSource.camera);

                    await imageFromCamera();
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
    log('Get All Company List Api Url :$url');

    try {
      http.Response response = await http.get(Uri.parse(url));

      // log("getAllCompanyFunction res body ::::${response.body}");

      AllCompanyModel allCompanyModel =
          AllCompanyModel.fromJson(json.decode(response.body));
      isSuccessStatus = allCompanyModel.success.obs;
      // log('GetAllCompany :,${response.body}');
      if (isSuccessStatus.value) {
        allCompanyList.clear();
        allCompanyList.addAll(allCompanyModel.data);

        companyDDSelectedItem = allCompanyList[0];

        // log('companyDDSelectedItem : ${companyDDSelectedItem!.userName}');

        companyStringList.clear();
        for (int i = 0; i < allCompanyList.length; i++) {
          companyStringList.add(allCompanyList[i].userName);
        }
      } else {
        log('getAllCompanyFunction Else');
      }
    } catch (e) {
      log('getAllCompanyFunction Error :$e');
      rethrow;
    } finally {
      // if (employeeOption == EmployeeOption.update) {
      //   // when update company that time
      //   await employeeGetByIdFunction();
      // } else if (employeeOption == CompanyOption.create) {
      //   // when create new company
      //   isLoading(false);
      // }

      isLoading(false);
      // if (employeeOption == EmployeeOption.update) {
      //   await getCompanyDepartmentFunction(companyId);
      //   log("companyId :; ${companyId}");
      // } else {
      // }
    }
  }

  Future<void> employeeGetByIdFunction() async {
    isLoading(true);
    String url = "${ApiUrl.getEmployeeDetailsApi}$employeeId";
    log('Employee Details Get By Id Api Url : $url');

    try {
      http.Response response = await http.get(Uri.parse(url));

      // log("employeeGetByIdFunction  ${response.body}");
      EmployeeGetByIdModel employeeGetByIdModel =
          EmployeeGetByIdModel.fromJson(json.decode(response.body));

      isSuccessStatus = employeeGetByIdModel.success.obs;

      if (isSuccessStatus.value) {
        firstNameController.text = employeeGetByIdModel.data.firstName;
        middleNameController.text = employeeGetByIdModel.data.middleName;
        lastNameController.text = employeeGetByIdModel.data.lastName;
        phoneNoController.text = employeeGetByIdModel.data.phoneNo;
        dateOfBrithController.text =
            employeeGetByIdModel.data.dateOfBrith.split(" ")[0];
        homeNoController.text = employeeGetByIdModel.data.homeNo;
        workNoController.text = employeeGetByIdModel.data.workPhone;

        hourlyRateController.text =
            employeeGetByIdModel.data.hourlyRate.toString();
        salaryController.text = employeeGetByIdModel.data.salary.toString();
        // startDateController.text = employeeGetByIdModel.data.startDate;
        isActiveController.text = employeeGetByIdModel.data.isActive;
        emailController.text = employeeGetByIdModel.data.email;
        lastDateController.text =
            employeeGetByIdModel.data.lastDayOfWork.toString();

        companyId = employeeGetByIdModel.data.companyid;
        departmentId = employeeGetByIdModel.data.departmentId;
        oldImageName = employeeGetByIdModel.data.photo;

        startDate = DateTime.parse(employeeGetByIdModel.data.startDate);
        startDateController.text =
            "${startDate.year}-${startDate.month}-${startDate.day}";

        birthDate = DateTime.parse(employeeGetByIdModel.data.dateOfBrith);
        dateOfBrithController.text =
            "${birthDate.year}-${birthDate.month}-${birthDate.day}";

        log('Photo : ${employeeGetByIdModel.data.photo}');
        // if (images != null) {
        // } else {
        //   oldImageName = employeeGetByIdModel.data.photo;
        // }

        for (int i = 0; i < allCompanyList.length; i++) {
          if (companyId == allCompanyList[i].id) {
            companyDDSelectedItem = allCompanyList[i];
          }
        }

        if (companyId != 0) {
          getCompanyDepartmentFunction(companyId);
        } else {}

        passwordController.text = employeeGetByIdModel.data.password;
        currentAddressController.text = employeeGetByIdModel.data.address;
        homeAddressController.text = employeeGetByIdModel.data.home;

        // Remove Braces From Api String
        // log('companyGetByIdModel.data.departmentId : ${employeeGetByIdModel.data.departmentId}');
        // String removedBracesString = employeeGetByIdModel.data.departmentId
        //     .toString()
        //     .substring(1,
        //         employeeGetByIdModel.data.departmentId.toString().length - 1);

        // for (int i = 0; i < companyDepartment.length; i++) {
        //   for (int j = 0; j < selectedDepartmentIdList.length; j++) {
        //     if (companyDepartment[i].id.toString().trim() ==
        //         selectedDepartmentIdList[j].trim()) {
        //       selectedDepartmentList.add(companyDepartment[i].departmentName);
        //     }
        //   }
        // }
        // log('selectedDepartmentList : $selectedDepartmentList');
      } else {
        log('getEmployeeDetailsFunction Else');
      }
    } catch (e) {
      log('getEmployeeDetailsFunction Error :$e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> getCompanyDepartmentFunction(int companyId) async {
    // isLoading(true);
    String url = ApiUrl.getCompanyDepartmentApi;
    log('Get COmpanyDepartment Api Url :$url');

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['id'] = companyId.toString();

      var response = await request.send();

      response.stream
          .transform(const Utf8Decoder())
          .transform(const LineSplitter())
          .listen((value) {
        log("getCompanyDepartmentFunction res body :: ${value}");
        CompanyDeprtmentModel companyDepartmentModel =
            CompanyDeprtmentModel.fromJson(json.decode(value));
        isSuccessStatus = companyDepartmentModel.success.obs;

        if (isSuccessStatus.value) {
          companyDepartment.clear();
          companyDepartment.addAll(companyDepartmentModel.data);

          if (employeeOption == EmployeeOption.create) {
            if (companyDepartment.isNotEmpty) {
              companyDepartmentData = companyDepartment[0];
            } else {
              Fluttertoast.showToast(msg: "No department in this company!");
            }
          } else if (employeeOption == EmployeeOption.update) {
            //update logic here

            for (int i = 0; i < companyDepartment.length; i++) {
              // ignore: unrelated_type_equality_checks
              if (departmentId == companyDepartment[i].id) {
                companyDepartmentData = companyDepartment[i];
              }
            }
          }
          departmentStringList.clear();
          log("companyDepartment ::::$companyDepartment");
          for (int i = 0; i < companyDepartment.length; i++) {
            departmentStringList.add(companyDepartment[i].departmentName);
          }
        } else {
          log('getAllCompanyFunction Else');
        }
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong !");

      rethrow;
    } finally {
      isLoading(true);
      isLoading(false);
    }
  }

  Future<void> employeeCreateFunction() async {
    isLoading(true);
    String url = ApiUrl.createEmployeeApi;
    // String url = "https://payroll.omdemo.co.in/api/employee/store";

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
      request.fields['department_id'] = "${companyDepartmentData!.id}";
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
      log("12323578");

      log("request.fields : ${request.fields}");
      log("request.files : ${request.files}");
      var response = await request.send();
      log('getEmployeeStore: $response');
      response.stream
          .transform(const Utf8Decoder())
          .transform(const LineSplitter())
          .listen((value) async {
        log('value employee : $value');
        // log(response.stream.toString());
        CraeteEmployeeModel employeeCreateModel =
            CraeteEmployeeModel.fromJson(json.decode(value.toString()));

        isSuccessStatus = employeeCreateModel.success.obs;
        if (isSuccessStatus.value) {
          Fluttertoast.showToast(msg: employeeCreateModel.messege);

          Get.back();
          await employeeListScreenController.getAllEmployeeFunction();
        } else {
          log('createCompanyFunction Else');
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

  /// Update Employee Details
  Future<void> updateEmployeeDetailsFunction() async {
    String url = ApiUrl.updateEmployeeDetailsApi;
    log('Update Company Api URl : $url');

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields['first_name'] = firstNameController.text.trim();
      request.fields['middle_name'] = middleNameController.text.trim();
      request.fields['last_name'] = lastNameController.text.trim();
      request.fields['password'] = passwordController.text.trim();
      request.fields['address'] = currentAddressController.text.trim();
      request.fields['phone_no'] = phoneNoController.text.trim();
      request.fields['email'] = emailController.text.trim();
      request.fields['department_id'] = "${companyDepartmentData!.id}";
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
      request.fields['showphotos'] = oldImageName;
      request.fields['id'] = employeeId;

      if (images != null) {
        request.files
            .add(await http.MultipartFile.fromPath("Photo", images!.path));
      }
      var response = await request.send();

      response.stream
          .transform(const Utf8Decoder())
          .transform(const LineSplitter())
          .listen((value) async {
        log('value Updateemployee : $value');
        UpdateEmployeeModel updateEmployeeModel =
            UpdateEmployeeModel.fromJson(json.decode(value));

        isSuccessStatus = updateEmployeeModel.success.obs;
        if (isSuccessStatus.value) {
          Fluttertoast.showToast(msg: updateEmployeeModel.messege);
          Get.back();
          await employeeListScreenController.getAllEmployeeFunction();
        } else {
          log('updateCompanyDetailsFunction Else');
        }
        log("Empliyee Details : $updateEmployeeModel");
      });
    } catch (e) {
      log('updateCompanyDetailsFunction Error :$e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    getAllCompanyFunction().whenComplete(() {
      if (employeeOption == EmployeeOption.update) {
        employeeGetByIdFunction();
      }
    });

    super.onInit();
  }

  loadUI() {
    isLoading(true);
    isLoading(false);
  }
}
