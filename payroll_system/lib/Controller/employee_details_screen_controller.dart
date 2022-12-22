import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:payroll_system/Utils/api_url.dart';
import 'package:sizer/sizer.dart';

class EmployeDetailsScreenController extends GetxController {
  DateTime? chosenDateTime;
  RxBool isLoading = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController textEditingController = TextEditingController();

  TextEditingController FirstName = TextEditingController(text: 'Reshma');
  TextEditingController middleName = TextEditingController(text: 'rajeshbhai');
  TextEditingController lastName = TextEditingController(text: 'khatrani');
  TextEditingController phoneNo = TextEditingController(text: '5566332211');

  TextEditingController dateOfBrith = TextEditingController();
  TextEditingController department = TextEditingController();

  TextEditingController homeNo = TextEditingController(text: '5');
  TextEditingController workNo = TextEditingController(text: '50');
  TextEditingController hourlyRate = TextEditingController(text: '500');

  TextEditingController salary = TextEditingController(text: '30000');

  TextEditingController startDate = TextEditingController(text: '10/10/2021');
  TextEditingController lastDate = TextEditingController(text: '10/10/2021');

  TextEditingController isActive = TextEditingController();

  TextEditingController company = TextEditingController();
  TextEditingController email =
      TextEditingController(text: 'afsaf22@gmail.com');
  TextEditingController password = TextEditingController(text: 'dd@123');
  TextEditingController CurrentAddress = TextEditingController(text: '1,gg');
  TextEditingController homeAddress = TextEditingController(text: '3.hfbhj d');

  File? images;
  var selectedDate = DateTime.now().obs;
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

  // datePicker(BuildContext context) async {
  //   DateTime? pickedDate = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(2000),
  //       lastDate: DateTime.now());

  //   if (pickedDate != null) {
  //     isloding(true);
  //     textEditingController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  //     isloding(false);
  //   }
  // }

  void showDatePicker(
    ctx,
  ) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
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

  Future<void> employeeStoreFunction() async {
    isLoading(true);
    String url = ApiUrl.employee;
    log(url);
  }
}
