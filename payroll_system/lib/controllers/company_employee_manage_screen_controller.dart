import 'dart:io';
import 'dart:convert';
import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:payroll_system/controllers/company_home_screen_controller.dart';
import 'package:payroll_system/models/company_manage_screen_model/get_all_department_model.dart';
import 'package:payroll_system/models/location_list_screen_model/location_list_screen_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import '../constants/enums.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payroll_system/utils/messaging.dart';
import '../models/company_list_screen_model/get_all_company_model.dart';
import '../models/employee_manage_screen_models/employee_get_by_id_model.dart';
import 'package:payroll_system/models/company_department_model/company_department_model.dart';
import 'package:payroll_system/models/employee_manage_screen_models/create_employee_model.dart';
import 'package:payroll_system/models/employee_manage_screen_models/update_employee_model.dart';

class CompanyEmployeeManageScreenController extends GetxController {
  EmployeeOption employeeOption = Get.arguments[0];
  String employeeId = Get.arguments[1] ?? "";
  String companyId = Get.arguments[2];
  String companyName = Get.arguments[3];

  List<LocationListData> allLocationList = [];
  LocationListData? locationListData;
  DateTime? chosenDateTime;
  DateTime selectedDate = DateTime.now();
  RxBool isPasswordVisible = true.obs;
  List<String> isActiveOptionList = [
    "Choose Option",
    "Active",
    "In-Active",
    "Terminated"
  ];
  RxString selectedValue = "Choose Option".obs;

  List<String> isPayperList = ["Choose Option", "Salary", "Hourly"];
  RxString selectedValuePayper = "Choose Option".obs;
  RxString selectedCompanyValue = "Choose Company".obs;
  RxString selectedDepartmentValue = "Choose Department".obs;

  RxBool isLoading = false.obs;
  RxList<String> selectedDepartmentList = RxList<String>([]);

  Rx<List<String>> selectedCompanyList = Rx<List<String>>([]);

  List<String> selectedDepartmentIdList = [];
  List<String> selectedCompanyIdList = [];
  final companyHomeScreenController = Get.find<CompanyHomeScreenController>();

  RxBool isSuccessStatus = false.obs;
  

  List<String> departmentStringList = [];
  List<String> companyStringList = [];
  List<String> locationStringList = [];

  // int companyId = 0;
  int departmentId = 0;

  DateTime birthDate = DateTime.now();
  DateTime employmentStartDate = DateTime.now();
  DateTime employmentEndDate = DateTime.now();

  List<CompanyData> allCompanyList = [];
  List<CompanyDepartmentData> companyDepartment = [];

  CompanyData? companyDDSelectedItem;
  String companyDDSelectedStringItem = '';
  CompanyDepartmentData? companyDepartmentData;
  String companyLocationSelectedStringItem = '';

  RxString selectedDepartmentOption = "".obs;
  RxString selectedCompanyOption = "".obs;

  RxList<String> selectedEmpDepartmentList = RxList<String>([]);
  List<String> selectedEmpDepartmentIdList = [];
  List<DepartmentData> allDepartmentList = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController homeNoController = TextEditingController();
  TextEditingController workNoController = TextEditingController();
  TextEditingController hourlyRateController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController lastDateController = TextEditingController();
  TextEditingController isActiveController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController currentAddressController = TextEditingController();
  TextEditingController homeAddressController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController landmarkAddressController = TextEditingController();
  TextEditingController zipcodeAddressController = TextEditingController();
  TextEditingController cityAddressController = TextEditingController();
  TextEditingController stateAddressController = TextEditingController();

  File? images;
  String oldImageName = "";

  List<File> employeeSelectedDocumentList = [];

  int userIdPrefs = 0;
  UserPreference userPreference = UserPreference();

  imageFromCamera() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    if (image != null) {
      isLoading(true);
      images = File(image.path);
      isLoading(false);
    }

    Get.back();
  }

  imageFromGallery() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      isLoading(true);

      images = File(image.path);
      isLoading(false);
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
                  title: Text(AppMessage.gallery),
                  onTap: () async {
                    // employeDetailsFormController.getImage(ImageSource.gallery);

                    await imageFromGallery();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: Text(AppMessage.camera),
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

  Future<void> pickEmployeeDocumentFunction() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf'],
    );

    if (result != null) {
      isLoading(true);

      for (int i = 0; i < result.paths.length; i++) {
        employeeSelectedDocumentList.add(File(result.paths[i]!));
      }
      log('files Inner :${employeeSelectedDocumentList.length}');
      isLoading(false);
    } else {
      // User canceled the picker
    }
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
                    log("$newdate");
                    isLoading(true);
                    chosenDateTime = newdate;
                    isLoading(false);
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
        // log('allCompanyList : ${allCompanyList.length}');

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
      /*if (employeeOption == EmployeeOption.update) {
        // when update company that time
        await employeeGetByIdFunction();
      } else if (employeeOption == CompanyOption.create) {
        // when create new company
        await getCompanyDepartmentFunction(companyDDSelectedItem!.id);
        isLoading(false);
      }*/
    }

    // isLoading(false);

    if (employeeOption == EmployeeOption.update) {
      // when update company that time
      await employeeGetByIdFunction();
    } else if (employeeOption == EmployeeOption.create) {
      // when create new company
      await getCompanyWiseDepartmentFunction();

      // isLoading(false);
    }
  }

  Future<void> employeeGetByIdFunction() async {
    isLoading(true);
    String url = "${ApiUrl.getEmployeeDetailsApi}$employeeId/$companyId";
    log('Employee Details Get By Id Api Url : $url');

    try {
      http.Response response = await http.get(Uri.parse(url));

      log("employeeGetByIdFunction  ${response.body}");
      EmployeeGetByIdModel employeeGetByIdModel =
          EmployeeGetByIdModel.fromJson(json.decode(response.body));

      isSuccessStatus = employeeGetByIdModel.success.obs;

      if (isSuccessStatus.value) {
        firstNameController.text = employeeGetByIdModel.data.firstName;
        middleNameController.text = employeeGetByIdModel.data.middleName;
        lastNameController.text = employeeGetByIdModel.data.lastName;
        phoneNoController.text = employeeGetByIdModel.data.mobileNumber;
        log('employeeGetByIdModel.data.dateOfBirth : ${employeeGetByIdModel.data.dateOfBirth}');
        if(employeeGetByIdModel.data.dateOfBirth.toString().contains(" ")){
        dateOfBirthController.text =
            employeeGetByIdModel.data.dateOfBirth.toString().split(" ")[0];
        }
        // birthDate = employeeGetByIdModel.data.dateOfBirth;
        selectedValuePayper.value =
            employeeGetByIdModel.data.payPeriod == "salary"
                ? "Salary"
                : "Hourly";
        salaryController.text = employeeGetByIdModel.data.salary.toString();
        hourlyRateController.text =
            employeeGetByIdModel.data.hourlyRate.toString();
        emailController.text = employeeGetByIdModel.data.email;
        streetAddressController.text = employeeGetByIdModel.data.street;
        landmarkAddressController.text = employeeGetByIdModel.data.town;
        cityAddressController.text = employeeGetByIdModel.data.city;
        stateAddressController.text = employeeGetByIdModel.data.state;
        zipcodeAddressController.text = employeeGetByIdModel.data.zipcode;

        startDateController.text = employeeGetByIdModel.data.employmentStartDate
            .toString()
            .split(" ")[0];
        employmentStartDate = employeeGetByIdModel.data.employmentStartDate;

        endDateController.text = employeeGetByIdModel.data.employmentEndDate
            .toString()
            .split(" ")[0];
        employmentEndDate = employeeGetByIdModel.data.employmentEndDate;

        selectedValue.value = employeeGetByIdModel.data.isActive == "0"
            ? "In-Active"
            : employeeGetByIdModel.data.isActive == "1"
                ? "Active"
                : "Terminated";

        for (int i = 0; i < companyDepartment.length; i++) {
          if (companyDepartment[i].id ==
              employeeGetByIdModel.data.departmentId) {
            companyDepartmentData = companyDepartment[i];
          }
        }

        for (int i = 0; i < allLocationList.length; i++) {
          if (allLocationList[i].id == employeeGetByIdModel.data.locationId) {
            locationListData = allLocationList[i];
          }
        }

      
      } else {
        log('getEmployeeDetailsFunction Else');
      }
    } catch (e) {
      log('getEmployeeDetailsFunction Error :$e');
      rethrow;
    } finally {
      isLoading(false);
    }

    // await getCompanyDepartmentFunction(companyId);
  }

  Future<void> getCompanyWiseDepartmentFunction() async {
    isLoading(true);
    String url = "${ApiUrl.getCompanyDepartmentApi}$companyId";
    log('Get Company Department Api Url :$url');

    try {
      http.Response response = await http.get(Uri.parse(url));
      CompanyDeprtmentModel companyDepartmentModel =
          CompanyDeprtmentModel.fromJson(json.decode(response.body));
      isSuccessStatus = companyDepartmentModel.success.obs;
      log("getCompanyWiseDepartmentFunction response :${response.body}");
      if (isSuccessStatus.value) {
        companyDepartment.clear();
        companyDepartment.addAll(companyDepartmentModel.data);

        if (employeeOption == EmployeeOption.create) {
          if (companyDepartment.isNotEmpty) {
            companyDepartmentData = companyDepartment[0];
          } else {
            // Fluttertoast.showToast(msg: "No department in this company!");
          }
        } else if (employeeOption == EmployeeOption.update) {
          // update logic here

          for (int i = 0; i < companyDepartment.length; i++) {
            if (departmentId == companyDepartment[i].id) {
              companyDepartmentData = companyDepartment[i];
            }
          }
        }
        departmentStringList.clear();

        for (int i = 0; i < companyDepartment.length; i++) {
          departmentStringList.add(companyDepartment[i].departmentName);
        }

        log('allDepartmentList : ${companyDepartment.length}');
      } else {
        log('getAllCompanyFunction Else');
      }
      // });
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong !");
      rethrow;
    } /*finally {
      isLoading(false);
    }*/
    await getCompanyWiseLocationFunction(companyId);
  }

  /// Company wise location
  Future<void> getCompanyWiseLocationFunction(companyId) async {
    isLoading(true);
    String url = "${ApiUrl.companyWiseLocationApi}$companyId";
    // log('Company Wise Location Api Url : $url');

    try {
      http.Response response = await http.get(Uri.parse(url));
      // log('response : ${response.body}');

      AllLocationListModel allLocationListModel =
          AllLocationListModel.fromJson(json.decode(response.body));
      isSuccessStatus = allLocationListModel.success.obs;

      if (isSuccessStatus.value) {
        allLocationList.clear();
        allLocationList.addAll(allLocationListModel.data);
        locationListData = allLocationList[0];

        for (int i = 0; i < allLocationList.length; i++) {
          locationStringList.add(allLocationList[i].locationName);
        }
   
      } else {
        log('deleteCompanyFunction Else');
      }
    } catch (e) {
      log('deleteCompanyFunction Error :$e');
      rethrow;
    }
    //  finally {
    //   isLoading(false);
    // }

    if (employeeOption == EmployeeOption.update) {
      await employeeGetByIdFunction();
    } else {
      isLoading(false);
    }
  }

  /// Employee Create - Done
  Future<void> employeeCreateFunction() async {
    isLoading(true);
    String url = ApiUrl.createEmployeeApi;
    log("Employee Create Api Url : $url");

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields['first_name'] = firstNameController.text.trim();
      request.fields['middle_name'] = middleNameController.text.trim();
      request.fields['last_name'] = lastNameController.text.trim();
      request.fields['mobile_number'] = phoneNoController.text.trim();
      request.fields['date_of_birth'] = dateOfBirthController.text.trim();
      request.fields['pay_period'] =
          selectedValuePayper.value == "Salary" ? "salary" : "hourly";
      request.fields['salary'] = salaryController.text.trim() == ""
          ? "0"
          : salaryController.text.trim();
      request.fields['hourly_rate'] = hourlyRateController.text.trim() == ""
          ? "0"
          : hourlyRateController.text.trim();
      request.fields['employment_start_date'] = startDateController.text.trim();
      request.fields['employment_end_date'] = endDateController.text.trim();
      request.fields['is_active'] = selectedValue.value == "Active"
          ? "1"
          : selectedValue.value == "In-Active"
              ? "0"
              : "2";
      request.fields['companyid'] = companyId;
      request.fields['department_id'] = "${companyDepartmentData!.id}";
      request.fields['location_id'] = "${locationListData!.id}";
      request.fields['email'] = emailController.text.trim();
      request.fields['password'] = passwordController.text.trim();
      request.fields['street'] = streetAddressController.text.trim();
      request.fields['town'] = landmarkAddressController.text.trim();
      request.fields['state'] = stateAddressController.text.trim();
      request.fields['city'] = cityAddressController.text.trim();
      request.fields['zipcode'] = zipcodeAddressController.text.trim();
      request.fields['userid'] = "$userIdPrefs";

      /*if (images != null) {
        request.files
            .add(await http.MultipartFile.fromPath("photo", images!.path));
      }*/

      log("request.fields : ${request.fields}");
      log("request.files : ${request.files}");
      var response = await request.send();
      log('getEmployeeStore: ${response.statusCode}');
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
          await companyHomeScreenController.getCompanyWiseEmployeeFunction();
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

      request.fields['id'] = employeeId;
      request.fields['first_name'] = firstNameController.text.trim();
      request.fields['middle_name'] = middleNameController.text.trim();
      request.fields['last_name'] = lastNameController.text.trim();
      request.fields['mobile_number'] = phoneNoController.text.trim();
      request.fields['date_of_birth'] = dateOfBirthController.text.trim();
      request.fields['pay_period'] =
          selectedValue.value == "Salary" ? "salary" : "hourly";
      request.fields['salary'] = salaryController.text.trim() == ""
          ? "0"
          : salaryController.text.trim();
      request.fields['hourly_rate'] = hourlyRateController.text.trim() == ""
          ? "0"
          : hourlyRateController.text.trim();
      request.fields['employment_start_date'] = startDateController.text.trim();
      request.fields['employment_end_date'] = endDateController.text.trim();
      request.fields['is_active'] = selectedValue.value == "Active"
          ? "1"
          : selectedValue.value == "In-Active"
              ? "0"
              : "2";
      request.fields['companyid'] = companyId;
      request.fields['department_id'] = "${companyDepartmentData!.id}";
      request.fields['location_id'] = "${locationListData!.id}";
      request.fields['email'] = emailController.text.trim();
      request.fields['password'] = passwordController.text.trim();
      request.fields['street'] = streetAddressController.text.trim();
      request.fields['town'] = landmarkAddressController.text.trim();
      request.fields['state'] = stateAddressController.text.trim();
      request.fields['city'] = cityAddressController.text.trim();
      request.fields['zipcode'] = zipcodeAddressController.text.trim();
      request.fields['userid'] = "$userIdPrefs";

      /*if (images != null) {
        request.files
            .add(await http.MultipartFile.fromPath("photo", images!.path));
      }*/
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
          await companyHomeScreenController.getCompanyWiseEmployeeFunction();
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

  getLoggedInUserIdFromPrefs() async {
    userIdPrefs = await userPreference.getIntValueFromPrefs(
        keyId: UserPreference.userIdKey);
    await getCompanyWiseDepartmentFunction();
  }

  @override
  void onInit() {
    companyDDSelectedStringItem = companyName;
    getLoggedInUserIdFromPrefs();
    super.onInit();
  }

  loadUI() {
    isLoading(true);
    isLoading(false);
  }
}
