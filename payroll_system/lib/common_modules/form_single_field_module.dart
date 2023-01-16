import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/utils/style.dart';

class FormSingleFieldModule extends StatelessWidget {
  final String text;
  final String headerText;
  final String mandatoryText;
  final bool isHeaderTextShow;
  // IconData prefixIcon;
  IconData? suffixIcon;
  final FormFieldValidator? validate;
  TextEditingController? textEditingController;
  final List<TextInputFormatter>? inputFormatters;
  Color color;
  Function()? onTap;
  // Function(String)? onChanged;
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
      this.isHeaderTextShow = true,
      this.inputFormatters,
      this.suffixIcon,
      this.color = Colors.grey,
      this.size,
      this.textEditingController,
      this.onTap,
        // this.onChanged,
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
        isHeaderTextShow == true ? RichText(
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
                  textColor: AppColors.colorRed,
                    fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ]
          ),
        ).commonSymmetricPadding(vertical: 4)
        : Container(),
        TextFormField(
          // obscureText: loginScreenController.isPasswordVisible.value,
          obscureText: obscureText,
          validator: validate,
          onTap: onTap,
          // onChanged: (value) => onChanged!(value),
          readOnly: readOnly,
          keyboardType: keyboardType,
          controller: textEditingController,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          decoration: InputDecoration(
            enabledBorder: InputFieldStyles().inputBorder(),
            focusedBorder: InputFieldStyles().inputBorder(),
            errorBorder: InputFieldStyles().inputBorder(),
            focusedErrorBorder: InputFieldStyles().inputBorder(),
            counterText: '',
            hintText: text,
            fillColor: AppColors.colorWhite,
            filled: true,
            hintStyle: const TextStyle(color: AppColors.colorLightHintPurple2),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            suffixIcon:
                IconButton(onPressed: onPressed, icon: Icon(suffixIcon, color: AppColors.colorLightHintPurple2,)),
            errorMaxLines: 2,
          ),
        ),
      ],
    );
  }
}
