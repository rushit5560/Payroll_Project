import 'package:flutter/material.dart';
import 'package:payroll_system/Utils/style.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class DownloadButtonModule extends StatelessWidget {
  Function() onDownloadTap;
  final String downloadLabelText;

  DownloadButtonModule({
    Key? key,
    required this.onDownloadTap,
    required this.downloadLabelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.greenColor),
          ),
          onPressed: onDownloadTap,
          child: Text(
            downloadLabelText,
            style: TextStyleConfig.textStyle(
              fontSize: 14.sp,
              textColor: AppColors.whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}
