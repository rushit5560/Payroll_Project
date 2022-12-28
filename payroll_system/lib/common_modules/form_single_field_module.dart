import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/Utils/style.dart';
import 'package:payroll_system/constants/colors.dart';

class FormSingleFieldModule extends StatelessWidget {
  final String text;
  final String headerText;
  final String mandatoryText;
  // IconData prefixIcon;
  IconData? suffixIcon;
  final FormFieldValidator? validate;
  TextEditingController? textEditingController;
  final List<TextInputFormatter>? inputFormatters;
  Color color;
  Function()? onTap;
  Size? size;
  TextInputType? keyboardType;
  bool readOnly;
  int? maxLength;
  bool obscureText;
  Function()? onPressed;
  //  double fontSize = 15.0,
  FormSingleFieldModule(
      {Key? key,
      required this.text,
      required this.headerText,
      required this.mandatoryText,
      // required this.prefixIcon,
      this.inputFormatters,
      this.suffixIcon,
      this.color = Colors.grey,
      this.size,
      this.textEditingController,
      this.onTap,
      this.keyboardType,
      this.validate,
      this.maxLength,
      this.onPressed,
      this.obscureText = false,
      this.readOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          maxLines: null,
          text: TextSpan(
            text: headerText,
            style: TextStyleConfig.textStyle(
                fontWeight: FontWeight.w600, fontSize: 16,),
            children: [
              TextSpan(
                text: ' $mandatoryText',
                style: TextStyleConfig.textStyle(
                  textColor: AppColors.redColor,
                    fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ]
          ),
        ).commonSymmetricPadding(vertical: 2),
        /*Text(
          headerText,
          style: TextStyleConfig.textStyle(
              fontWeight: FontWeight.w600, fontSize: 16),
        ).commonSymmetricPadding(vertical: 2),*/
        TextFormField(
          // obscureText: loginScreenController.isPasswordVisible.value,
          obscureText: obscureText,
          validator: validate,
          onTap: onTap,
          readOnly: readOnly,
          keyboardType: keyboardType,
          controller: textEditingController,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          decoration: InputDecoration(
            // prefixIcon: Icon(prefixIcon, color: color),
            counterText: '',
            hintText: text,
            suffixIcon:
                IconButton(onPressed: onPressed, icon: Icon(suffixIcon)),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
