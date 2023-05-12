import 'package:flutter/material.dart';
import 'package:payroll/utils/extensions.dart';
import 'package:payroll/utils/style.dart';
import 'package:sizer/sizer.dart';


class SingleListTileCustom extends StatelessWidget {
  final String textKey;
  final String textValue;

  const SingleListTileCustom(
  {super.key, required this.textValue, required this.textKey});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            textKey,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyleConfig.textStyle(fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            textValue,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyleConfig.textStyle(),
          ),
        ),
      ],
    ).commonSymmetricPadding(vertical: 2);
  }
}