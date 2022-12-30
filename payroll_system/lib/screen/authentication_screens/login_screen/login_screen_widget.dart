// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Utils/style.dart';
import 'package:payroll_system/controllers/login_screen_controller.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';
import '../../../Utils/validator.dart';
import '../../../constants/colors.dart';
import '../Forgot_Password_Screen/forgot_password_screen.dart';

class LogInEmailTextFieldModule extends StatelessWidget {
  LogInEmailTextFieldModule({Key? key}) : super(key: key);

  final loginScreenController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: loginScreenController.loginEmailController,
      validator: (value) => FieldValidation().validateEmail(value!),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        // filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        hintText: AppMessage.emailAddress,
      ),
    );
  }
}

class PasswordTextFieldModule extends StatelessWidget {
  PasswordTextFieldModule({Key? key}) : super(key: key);

  final loginScreenController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        obscureText: loginScreenController.isPasswordVisible.value,
        validator: (value) => FieldValidation().validatePassword(value!),
        controller: loginScreenController.loginPasswordController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: AppMessage.password,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              loginScreenController.isPasswordVisible.value =
                  !loginScreenController.isPasswordVisible.value;
              // setState(() {
              // });
            },
            icon: Icon(
              loginScreenController.isPasswordVisible.value
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
          ),
        ),
      ),
    );
  }
}

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
            Get.to(() => ForgotPasswordScreen());
          },
          child: Text(
            AppMessage.forgotPassword,
            style: const TextStyle(decoration: TextDecoration.underline),
          ),
        ),
      ],
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
        height: 50,
        width: 60.w,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              // backgroundColor: Colors.blueAccent,

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
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SignInTextFormFiledCustom extends StatelessWidget {
  final String text;

  // IconData prefixIcon;
  IconData? suffixIcon;
  TextEditingController? textEditingController;

  final FormFieldValidator? validate;
  Function(String)? onChanged;
  Color color;
  Size? size;

  //  double fontSize = 15.0,
  SignInTextFormFiledCustom({
    Key? key,
    required this.text,
    this.validate,
    this.onChanged,
    this.textEditingController,
    // required this.prefixIcon,
    this.suffixIcon,
    this.color = Colors.grey,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validate,
      onChanged: onChanged,
      controller: textEditingController,
      decoration: InputDecoration(
        // prefixIcon: Icon(prefixIcon, color: color),
        // labelText: text,

        hintText: text,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        suffixIcon: Icon(suffixIcon),
      ),
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
            child: RichText(
              textAlign: TextAlign.left,
              maxLines: null,
              text: TextSpan(
                text: "I Agree with ",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.normal,
                ),
                children: [
                  TextSpan(
                    text: "privacy policy",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.redColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: " & ",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: "terms conditions",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.redColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class CompanyLogInCustom extends StatelessWidget {
//   const CompanyLogInCustom({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Text(AppMessage.dontHaveAnAccount),
//         SizedBox(width: 2.w),
//         GestureDetector(
//           onTap: () {
//
//             Get.to(
//               SignUpScreen(),
//             );
//           },
//           child: Text(
//             AppMessage.companyLogin,
//             style: const TextStyle(decoration: TextDecoration.underline),
//           ),
//         )
//       ],
//     );
//   }
// }
