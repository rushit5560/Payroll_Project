// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:payroll_system/Utils/validator.dart';
// import '../../../Controller/signup_screen_controller.dart';
//
// class NameTextFieldModule extends StatelessWidget {
//   NameTextFieldModule({Key? key}) : super(key: key);
//
//   final signUpScreenController = Get.find<SignUpScreenController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: signUpScreenController.nameController,
//       validator: (value) => FieldValidation().validateName(value!),
//       textInputAction: TextInputAction.next,
//       keyboardType: TextInputType.text,
//       decoration: const InputDecoration(
//         contentPadding: EdgeInsets.symmetric(horizontal: 15),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(10),
//           ),
//         ),
//         hintText: "User Name",
//       ),
//     );
//   }
// }
//
// class FullNameTextFieldModule extends StatelessWidget {
//   FullNameTextFieldModule({Key? key}) : super(key: key);
//
//   final signUpScreenController = Get.find<SignUpScreenController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: signUpScreenController.fullNameController,
//       validator: (value) => FieldValidation().validateFullName(value!),
//       textInputAction: TextInputAction.next,
//       keyboardType: TextInputType.text,
//       decoration: const InputDecoration(
//         contentPadding: EdgeInsets.symmetric(horizontal: 15),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(10),
//           ),
//         ),
//         hintText: "Full Name",
//       ),
//     );
//   }
// }
//
// class EmailTextFieldModule extends StatelessWidget {
//   EmailTextFieldModule({Key? key}) : super(key: key);
//
//   final signUpScreenController = Get.find<SignUpScreenController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: signUpScreenController.signUpEmailController,
//       validator: (value) => FieldValidation().validateEmail(value!),
//       textInputAction: TextInputAction.next,
//       keyboardType: TextInputType.emailAddress,
//       decoration: const InputDecoration(
//         contentPadding: EdgeInsets.symmetric(horizontal: 15),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(10),
//           ),
//         ),
//         hintText: "Email Address",
//       ),
//     );
//   }
// }
//
// class MobileNumberTextFieldModule extends StatelessWidget {
//   MobileNumberTextFieldModule({Key? key}) : super(key: key);
//
//   final signUpScreenController = Get.find<SignUpScreenController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: signUpScreenController.mobileNoController,
//       validator: (value) => FieldValidation().validateMobileNumber(value!),
//       textInputAction: TextInputAction.next,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(
//         contentPadding: const EdgeInsets.symmetric(horizontal: 15),
//         border: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(10),
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(width: 0, style: BorderStyle.none),
//         ),
//         hintText: "Mobile Number",
//       ),
//     );
//   }
// }
