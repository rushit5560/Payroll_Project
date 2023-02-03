import 'package:flutter/material.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:sizer/sizer.dart';


class SingleListTileModuleCustom extends StatelessWidget {
  final String textKey;
  final String image;
  final String textValue;
  Color? valueColor;

  SingleListTileModuleCustom({
    super.key,
    required this.textValue,
    required this.image,
    required this.textKey,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              Image.asset(
                image,
                width: 15,
                height: 15,
                // color: AppColors.colorLightHintPurple2,
              ),
              Expanded(
                child: Text(
                  textKey,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleConfig.textStyle(
                    fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  // textColor: AppColors.colorLightHintPurple2
                  ),
                ).commonOnlyPadding(left: 5),
              ),
            ],
          ),
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            textValue,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyleConfig.textStyle(
              textColor: valueColor ?? AppColors.colorBlack
            ),
          ),
        ),
      ],
    ).commonSymmetricPadding(vertical: 2);
  }
}