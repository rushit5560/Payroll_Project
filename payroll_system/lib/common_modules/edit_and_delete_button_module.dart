import 'package:flutter/material.dart';
import 'package:payroll_system/Utils/messaging.dart';
import 'package:payroll_system/Utils/style.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:sizer/sizer.dart';

class EditAndDeleteButtonModule extends StatelessWidget {
  Function() onEditTap;
  Function() onDeleteTap;

  EditAndDeleteButtonModule(
      {Key? key, required this.onEditTap, required this.onDeleteTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 5,
          child: ElevatedButton(
            onPressed: onEditTap,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.greenColor),
            ),
            child: Text(
              AppMessage.edit,
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
              backgroundColor: MaterialStateProperty.all(AppColors.redColor),
            ),
            onPressed: onDeleteTap,
            child: Text(
              AppMessage.delete,
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
