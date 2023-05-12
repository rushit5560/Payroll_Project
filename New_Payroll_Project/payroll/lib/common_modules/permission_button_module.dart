import 'package:flutter/material.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/utils/messaging.dart';
import 'package:payroll/utils/style.dart';
import 'package:sizer/sizer.dart';

class PermissionButtonModule extends StatelessWidget {
  Function() onPermissionTap;
  PermissionButtonModule({super.key, required this.onPermissionTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.greenColor),
      ),
      
      onPressed: onPermissionTap,
      child: Text(
        AppMessage.permission,
        style: TextStyleConfig.textStyle(
          fontSize: 14.sp,
          textColor: AppColors.whiteColor,
        ),
      ),
    );
  }
}
