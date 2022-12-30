import 'package:flutter/material.dart';
import 'package:payroll_system/Utils/messaging.dart';
import 'package:payroll_system/Utils/style.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:sizer/sizer.dart';

class ViewButtonModule extends StatelessWidget {
  Function() onTap;

  ViewButtonModule({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 5,
          child: Container(),
        ),
        SizedBox(width: 4.w),
        Expanded(
          flex: 5,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.blueColor),
            ),
            onPressed: onTap,
            child: Text(
              AppMessage.view,
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
