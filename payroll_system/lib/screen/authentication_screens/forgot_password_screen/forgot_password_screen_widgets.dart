import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/forgot_password_screen_controller.dart';
import '../../../utils/messaging.dart';
import '../../../utils/validator.dart';

class ForgotPassTextModule extends StatelessWidget {
  ForgotPassTextModule({super.key});

  final forgotPasswordScreenController =
      Get.find<ForgotPasswordScreenController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Forgot Password",
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}

class EmailFieldModule extends StatelessWidget {
  EmailFieldModule({super.key});

  final forgotPasswordScreenController =
      Get.find<ForgotPasswordScreenController>();

  @override
  Widget build(BuildContext context) {
    var border = const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      borderSide: BorderSide(color: AppColors.greyColor),
    );
    return Form(
      key: forgotPasswordScreenController.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: forgotPasswordScreenController.emailController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => FieldValidation().validateEmail(value!),
            decoration: InputDecoration(
              isDense: true,
              labelText: "Enter email address",
              border: border,
              enabledBorder: border,
              focusedBorder: border,
            ),
          ),
        ],
      ),
    );
  }
}

class SubmitButtonModule extends StatelessWidget {
  SubmitButtonModule({super.key});

  final forgotPasswordScreenController =
      Get.find<ForgotPasswordScreenController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        onPressed: () {
          if (forgotPasswordScreenController.formKey.currentState!.validate()) {
            forgotPasswordScreenController.forgotPasswordFunction();
          }
        },
        child: Text(
          "Submit",
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w500,
            fontSize: 15.sp,
          ),
        ),
      ),
    );
  }
}
