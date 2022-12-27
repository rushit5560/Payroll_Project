import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Utils/validator.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/style.dart';
import '../../../constants/colors.dart';
import '../../../controllers/change_password_screen_controller.dart';

class LogInCurrentPasswordTextFieldModule extends StatelessWidget {
  LogInCurrentPasswordTextFieldModule({Key? key}) : super(key: key);

  final changePasswordScreenController = Get.find<ChangePasswordController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        obscureText: changePasswordScreenController.isPasswordVisible.value,
        controller: changePasswordScreenController.oldPasswordController,
        validator: (value) => FieldValidation().validatePassword(value!),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          // filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          hintText: AppMessage.oldPassword,
          suffixIcon: IconButton(
            onPressed: () {
              changePasswordScreenController.isPasswordVisible.value =
                  !changePasswordScreenController.isPasswordVisible.value;
            },
            icon: Icon(
              changePasswordScreenController.isPasswordVisible.value
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
          ),
        ),
      ),
    );
  }
}

class LogInNewPasswordTextFieldModule extends StatelessWidget {
  LogInNewPasswordTextFieldModule({Key? key}) : super(key: key);

  final changePasswordScreenController = Get.find<ChangePasswordController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        obscureText: changePasswordScreenController.isnewPasswordVisible.value,
        controller: changePasswordScreenController.newPasswordController,
        validator: (value) => FieldValidation().validatePassword(value!),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          // filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          hintText: AppMessage.newPassword,
          suffixIcon: IconButton(
            onPressed: () {
              changePasswordScreenController.isnewPasswordVisible.value =
                  !changePasswordScreenController.isnewPasswordVisible.value;
            },
            icon: Icon(
              changePasswordScreenController.isnewPasswordVisible.value
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
          ),
        ),
      ),
    );
  }
}

class LogInNewConfirmPasswordTextFieldModule extends StatelessWidget {
  LogInNewConfirmPasswordTextFieldModule({Key? key}) : super(key: key);

  final changePasswordScreenController = Get.find<ChangePasswordController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        obscureText:
            changePasswordScreenController.isConfirmPasswordVisible.value,
        controller: changePasswordScreenController.newConfirmPasswordController,
        validator: (value) {
          if (value!.isEmpty) {
            return "Confirmpassword is required";
          }
          if (value.length < 8) {
            return "Password must be at least 8 characters long";
          }
          if (changePasswordScreenController.newPasswordController.text !=
              changePasswordScreenController
                  .newConfirmPasswordController.text) {
            return "please enter a correct password";
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          hintText: AppMessage.newConfirmPassword,
          suffixIcon: IconButton(
            onPressed: () {
              changePasswordScreenController.isConfirmPasswordVisible.value =
                  !changePasswordScreenController
                      .isConfirmPasswordVisible.value;
            },
            icon: Icon(
              changePasswordScreenController.isConfirmPasswordVisible.value
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
          ),
        ),
      ),
    );
  }
}

class LoginButtonModule extends StatelessWidget {
  LoginButtonModule({Key? key}) : super(key: key);

  final changePasswordScreenController = Get.find<ChangePasswordController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: 60.w,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              // backgroundColor: Colors.blueAccent,

              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )),
          onPressed: () async {
            if (changePasswordScreenController.formKey.currentState!
                .validate()) {
              log("message");
              await changePasswordScreenController.changePasswordFunction();
            }
          },
          child: Text(
            AppMessage.changePassword,
            style: TextStyleConfig.textStyle(
              textColor: AppColors.whiteColor,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}
