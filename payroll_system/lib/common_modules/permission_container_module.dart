// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/style.dart';

class PermissionContainerModule extends StatelessWidget {
  final String labelText;

  final bool isViewValue;
  Function(bool?) isViewOnChanged;

  final bool isAddValue;
  Function(bool?) isAddOnChanged;

  final bool isEditValue;
  Function(bool?) isEditOnChanged;
  //
  final bool isDeleteValue;
  Function(bool?) isDeleteOnChanged;

  PermissionContainerModule({
    Key? key,
    required this.labelText,
    required this.isViewValue,
    required this.isViewOnChanged,
    required this.isAddValue,
    required this.isAddOnChanged,
    required this.isEditValue,
    required this.isEditOnChanged,
    required this.isDeleteValue,
    required this.isDeleteOnChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyleConfig.textStyle(
                fontSize: 19, fontWeight: FontWeight.bold),
          ),
          const Divider(color: AppColors.colorLightHintPurple2),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppMessage.isView,
                style: TextStyleConfig.textStyle(fontSize: 12.sp),
              ),
              Checkbox(
                value: isViewValue,
                onChanged: isViewOnChanged,
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppMessage.isAdd,
                style: TextStyleConfig.textStyle(fontSize: 12.sp),
              ),
              Checkbox(value: isAddValue, onChanged: isAddOnChanged),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppMessage.isEdit,
                style: TextStyleConfig.textStyle(fontSize: 12.sp),
              ),
              Checkbox(value: isEditValue, onChanged: isEditOnChanged),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppMessage.isDelete,
                style: TextStyleConfig.textStyle(fontSize: 12.sp),
              ),
              Checkbox(
                value: isDeleteValue,
                onChanged: isDeleteOnChanged,
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ).commonOnlyPadding(left: 10, right: 10, top: 10, bottom: 10),
    );
  }
}


class PermissionBoxModule extends StatelessWidget {
  final String labelText;
  final bool isViewShow;
  final bool isAddShow;
  final bool isEditShow;
  final bool isDeleteShow;
  final bool isDownloadShow;

  final bool? isViewValue;
  Function(bool?)? isViewOnChanged;

  final bool? isAddValue;
  Function(bool?)? isAddOnChanged;

  final bool? isEditValue;
  Function(bool?)? isEditOnChanged;
  //
  final bool? isDeleteValue;
  Function(bool?)? isDeleteOnChanged;

  final bool? isDownloadValue;
  Function(bool?)? isDownloadOnChanged;

  PermissionBoxModule({
    Key? key,
    required this.labelText,
    required this.isViewShow,
    required this.isAddShow,
    required this.isEditShow,
    required this.isDeleteShow,
    required this.isDownloadShow,

    this.isViewValue,
    this.isViewOnChanged,
    this.isAddValue,
    this.isAddOnChanged,
    this.isEditValue,
    this.isEditOnChanged,
    this.isDeleteValue,
    this.isDeleteOnChanged,
    this.isDownloadValue,
    this.isDownloadOnChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyleConfig.textStyle(
                fontSize: 19, fontWeight: FontWeight.bold),
          ),
          const Divider(color: AppColors.colorLightHintPurple2),

          isViewShow == false ? const SizedBox() : const SizedBox(height: 2),
          isViewShow == false ? const SizedBox() : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppMessage.isView,
                      style: TextStyleConfig.textStyle(fontSize: 12.sp),
                    ),
                    Checkbox(
                      value: isViewValue,
                      onChanged: isViewOnChanged,
                    ),
                  ],
                ),

          isAddShow == false ? const SizedBox() : const SizedBox(height: 2),
          isAddShow == false ? const SizedBox() : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppMessage.isAdd,
                style: TextStyleConfig.textStyle(fontSize: 12.sp),
              ),
              Checkbox(value: isAddValue, onChanged: isAddOnChanged),
            ],
          ),


          isEditShow == false ? const SizedBox() : const SizedBox(height: 2),
          isEditShow == false ? const SizedBox() : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppMessage.isEdit,
                style: TextStyleConfig.textStyle(fontSize: 12.sp),
              ),
              Checkbox(value: isEditValue, onChanged: isEditOnChanged),
            ],
          ),


          isDeleteShow == false ? const SizedBox() : const SizedBox(height: 2),
          isDeleteShow == false ? const SizedBox() : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppMessage.isDelete,
                style: TextStyleConfig.textStyle(fontSize: 12.sp),
              ),
              Checkbox(
                value: isDeleteValue,
                onChanged: isDeleteOnChanged,
              ),
            ],
          ),

          isDownloadShow == false ? const SizedBox() : const SizedBox(height: 2),
          isDownloadShow == false ? const SizedBox() : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppMessage.isDownload,
                style: TextStyleConfig.textStyle(fontSize: 12.sp),
              ),
              Checkbox(
                value: isDownloadValue,
                onChanged: isDownloadOnChanged,
              ),
            ],
          ),


          // const SizedBox(height: 10),
        ],
      ).commonOnlyPadding(left: 10, right: 10, top: 10, bottom: 10),
    );
  }
}