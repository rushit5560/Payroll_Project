import 'package:flutter/material.dart';
import 'package:payroll_system/Utils/messaging.dart';
import 'package:payroll_system/Utils/style.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:sizer/sizer.dart';

class ViewAndEditButtonModule extends StatelessWidget {
  Function() onViewTap;
  Function() onEditTap;
  final String viewLabelText;
  final String editLabelText;

  ViewAndEditButtonModule({Key? key,
    required this.onViewTap,
    required this.onEditTap,
    required this.viewLabelText,
    required this.editLabelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 5,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.blueColor),
            ),
            onPressed: onEditTap,
            child: Text(
              editLabelText,
              style: TextStyleConfig.textStyle(
                fontSize: 14.sp,
                textColor: AppColors.whiteColor,
              ),
            ),
          ),
        ),
        SizedBox(width: 4.w),
        Expanded(
          flex: 5,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.blueColor),
            ),
            onPressed: onViewTap,
            child: Text(
              viewLabelText,
              style: TextStyleConfig.textStyle(
                fontSize: 14.sp,
                textColor: AppColors.whiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
