import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/validator.dart';
import 'package:sizer/sizer.dart';
import '../../../Utils/style.dart';
import '../../../constants/colors.dart';
import '../../../controllers/change_password_screen_controller.dart';

class CurrentPasswordTextFieldModule extends StatelessWidget {
  CurrentPasswordTextFieldModule({Key? key}) : super(key: key);

  final changePasswordScreenController = Get.find<ChangePasswordController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              textAlign: TextAlign.left,
              maxLines: null,
              text: TextSpan(
                  text: AppMessage.oldPassword,
                  style: TextStyleConfig.textStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: ' ${AppMessage.mandatory}',
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.colorRed,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ]),
            ).commonSymmetricPadding(vertical: 4),
            const SizedBox(height: 5),
            TextFormField(
              obscureText:
                  changePasswordScreenController.isPasswordVisible.value,
              controller: changePasswordScreenController.oldPasswordController,
              validator: (value) =>
                  FieldValidation().validateOldPassword(value!),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                enabledBorder: InputFieldStyles().inputBorder(),
                focusedBorder: InputFieldStyles().inputBorder(),
                errorBorder: InputFieldStyles().inputBorder(),
                focusedErrorBorder: InputFieldStyles().inputBorder(),
                errorMaxLines: 2,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                fillColor: AppColors.colorWhite,
                filled: true,
                labelText: AppMessage.oldPassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    changePasswordScreenController.isPasswordVisible.value =
                        !changePasswordScreenController.isPasswordVisible.value;
                  },
                  icon: Icon(
                    changePasswordScreenController.isPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColors.colorLightHintPurple2,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class NewPasswordTextFieldModule extends StatelessWidget {
  NewPasswordTextFieldModule({Key? key}) : super(key: key);

  final changePasswordScreenController = Get.find<ChangePasswordController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            textAlign: TextAlign.left,
            maxLines: null,
            text: TextSpan(
                text: AppMessage.newPassword,
                style: TextStyleConfig.textStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                children: [
                  TextSpan(
                    text: ' ${AppMessage.mandatory}',
                    style: TextStyleConfig.textStyle(
                      textColor: AppColors.colorRed,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ]),
          ).commonSymmetricPadding(vertical: 4),
          const SizedBox(height: 5),
          TextFormField(
            obscureText:
                changePasswordScreenController.isNewPasswordVisible.value,
            controller: changePasswordScreenController.newPasswordController,
            validator: (value) => FieldValidation().validateNewPassword(value!),
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              enabledBorder: InputFieldStyles().inputBorder(),
              focusedBorder: InputFieldStyles().inputBorder(),
              errorBorder: InputFieldStyles().inputBorder(),
              focusedErrorBorder: InputFieldStyles().inputBorder(),
              errorMaxLines: 2,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
              fillColor: AppColors.colorWhite,
              filled: true,
              labelText: AppMessage.newPassword,
              suffixIcon: IconButton(
                onPressed: () {
                  changePasswordScreenController.isNewPasswordVisible.value =
                      !changePasswordScreenController
                          .isNewPasswordVisible.value;
                },
                icon: Icon(
                  changePasswordScreenController.isNewPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: AppColors.colorLightHintPurple2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NewConfirmPasswordTextFieldModule extends StatelessWidget {
  NewConfirmPasswordTextFieldModule({Key? key}) : super(key: key);

  final changePasswordScreenController = Get.find<ChangePasswordController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            textAlign: TextAlign.left,
            maxLines: null,
            text: TextSpan(
                text: AppMessage.newConfirmPassword,
                style: TextStyleConfig.textStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                children: [
                  TextSpan(
                    text: ' ${AppMessage.mandatory}',
                    style: TextStyleConfig.textStyle(
                      textColor: AppColors.colorRed,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ]),
          ).commonSymmetricPadding(vertical: 4),
          const SizedBox(height: 5),
          TextFormField(
            obscureText:
                changePasswordScreenController.isConfirmPasswordVisible.value,
            controller:
                changePasswordScreenController.newConfirmPasswordController,
            validator: (value) => FieldValidation().validateConfirmPassword(
              value!,
              changePasswordScreenController.newPasswordController.text.trim(),
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              enabledBorder: InputFieldStyles().inputBorder(),
              focusedBorder: InputFieldStyles().inputBorder(),
              errorBorder: InputFieldStyles().inputBorder(),
              focusedErrorBorder: InputFieldStyles().inputBorder(),
              errorMaxLines: 2,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
              fillColor: AppColors.colorWhite,
              filled: true,
              labelText: AppMessage.newConfirmPassword,
              suffixIcon: IconButton(
                onPressed: () {
                  changePasswordScreenController
                          .isConfirmPasswordVisible.value =
                      !changePasswordScreenController
                          .isConfirmPasswordVisible.value;
                },
                icon: Icon(
                  changePasswordScreenController.isConfirmPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: AppColors.colorLightHintPurple2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChangePasswordButtonModule extends StatelessWidget {
  ChangePasswordButtonModule({Key? key}) : super(key: key);

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
              await changePasswordScreenController.changePasswordFunction();
            }
          },
          child: Text(
            AppMessage.changePassword,
            style: TextStyleConfig.textStyle(
              textColor: AppColors.whiteColor,
              fontSize: 15.sp,
            ),
          ),
        ),
      ),
    );
  }
}
