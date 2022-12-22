import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/Utils/style.dart';

class FormSingleFieldModule extends StatelessWidget {
  final String text;
  final String headerText;
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

  //  double fontSize = 15.0,
  FormSingleFieldModule(
      {Key? key,
        required this.text,
        required this.headerText,
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
        this.readOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            headerText,
          style: TextStyleConfig.textStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16
          ),
        ).commonSymmetricPadding(vertical: 2),
        TextFormField(
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
