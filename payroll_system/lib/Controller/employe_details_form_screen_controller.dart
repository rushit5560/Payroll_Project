import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EmployeDetailsFormScreenController extends GetxController {
  TextEditingController textEditingController = TextEditingController();

  TextEditingController FirstName = TextEditingController(text: 'Reshma');
  TextEditingController LastName = TextEditingController(text: 'Khatrani');
  TextEditingController address = TextEditingController(text: '5, Gurukrupa');
  TextEditingController email =
      TextEditingController(text: 'reshma22@gmail.com');
  TextEditingController departmentId = TextEditingController(text: '5');
  TextEditingController companyid = TextEditingController(text: '101');
  TextEditingController dateOfBrith = TextEditingController();
  TextEditingController homePhoneNumber =
      TextEditingController(text: '9007625378');
  TextEditingController workPhoneNumber =
      TextEditingController(text: '1234567890');
  TextEditingController hourlyRate = TextEditingController(text: '500');
  TextEditingController salary = TextEditingController(text: '30000');
  TextEditingController firstDateOfWork =
      TextEditingController(text: '10/10/2021');

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

  datePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      isloding(true);
      textEditingController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      isloding(false);
    }

    //   .then(
    // (pickedDate) {
    //   if (pickedDate != null) {
    //     return;
    //   }
    //   isloding(true);
    //   textEditingController.text =
    //       DateFormat('yyyy-MM-dd').format(pickedDate!);
    //   isloding(false);

    //   // setState(() {

    //   // });
    // },
    // );
  }
}
