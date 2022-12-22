// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Controller/login_screen_controller.dart';
import 'package:payroll_system/Screen/Authentication/Sign_Up_Screen/sign_up_screen.dart';
import 'package:payroll_system/Utils/messaging.dart';
import 'package:payroll_system/Utils/style.dart';
import 'package:sizer/sizer.dart';
import '../../../Utils/validator.dart';
import '../../../constants/colors.dart';

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
      decoration: const InputDecoration(
        // filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        hintText: "Email Address",
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

  bool isChecked = false;
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            // isChecked = value!;
            isChecked = value!;
            // setState(
            //   () {
            //   },
            // );
          },
        ),
        const Text(
          "I Agree with ",
        ),
        Text(
          'provacy',
          style: TextStyleConfig.textStyle(textColor: Colors.red),
        ),
        const Text(' & '),
        Text(
          "policy",
          style: TextStyleConfig.textStyle(textColor: Colors.red),
        )
      ],
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
