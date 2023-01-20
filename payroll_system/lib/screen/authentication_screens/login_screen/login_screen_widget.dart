import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Utils/style.dart';
import 'package:payroll_system/controllers/login_screen_controller.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/colors.dart';

class ForgotPasswordTextModule extends StatelessWidget {
  ForgotPasswordTextModule({Key? key}) : super(key: key);

  final loginScreenController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Fluttertoast.showToast(msg: AppMessage.comingSoon);

            // Get.to(() => ForgotPasswordScreen());
          },
          child: Text(
            AppMessage.forgotPassword,
            style: const TextStyle(color: AppColors.colorBlue),
          ),
        ),
      ],
    );
  }
}

class PrivacyPolicyCustom extends StatelessWidget {
  PrivacyPolicyCustom({super.key});

  final loginScreenController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: loginScreenController.isPrivacyChecked.value,
            onChanged: (bool? value) {
              loginScreenController.isPrivacyChecked.value = value!;
            },
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Fluttertoast.showToast(msg: AppMessage.comingSoon);
              },
              child: RichText(
                textAlign: TextAlign.left,
                maxLines: null,
                text: TextSpan(
                  text: AppMessage.acceptText,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.normal,
                  ),
                  children: [
                    TextSpan(
                      text: " ${AppMessage.privacyPolicyText}",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.colorBlue,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginButtonModule extends StatelessWidget {
  LoginButtonModule({Key? key}) : super(key: key);

  final loginScreenController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        // height: 50,
        width: Get.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.colorBtBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              )),
          onPressed: () async {
            if (loginScreenController.formKey.currentState!.validate()) {
              if (loginScreenController.isPrivacyChecked.value) {
                await loginScreenController.loginUserFunction(context);
              } else {
                Fluttertoast.showToast(msg: AppMessage.privacyPolicyMessage);
              }
            }
          },
          child: Text(
            AppMessage.logIn,
            style: TextStyleConfig.textStyle(
              textColor: AppColors.whiteColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ).commonSymmetricPadding(vertical: 10),
        ),
      ),
    );
  }
}
