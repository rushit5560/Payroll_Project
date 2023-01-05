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
        border: Border.all(
          color: AppColors.greyColor,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyleConfig.textStyle(
                fontSize: 19, fontWeight: FontWeight.bold),
          ),
          const Divider(),
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

// class CompanyPermissionContainerModule extends StatelessWidget {
//   final String labelText;
//   final String isViewText;
//   final String isAddText;
//   final String isEditText;
//   final String isDeleteText;
//   final bool isCompanyChecked;
//   Function(bool?) isComapnyOnChanged;
//   CompanyPermissionContainerModule({
//     super.key,
//     required this.labelText,
//     required this.isViewText,
//     required this.isAddText,
//     required this.isEditText,
//     required this.isDeleteText,
//     required this.isCompanyChecked,
//     required this.isComapnyOnChanged,
//   });
//   final adminPermissionScreenController =
//       Get.find<AdminPermissionScreenController>();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: AppColors.greyColor,
//           width: 2,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             labelText,
//             style: TextStyleConfig.textStyle(
//                 fontSize: 19, fontWeight: FontWeight.bold),
//           ),
//           const Divider(),
//           const SizedBox(height: 2),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 isViewText,
//                 style: TextStyleConfig.textStyle(fontSize: 12.sp),
//               ),
//               Obx(
//                 () => Checkbox(
//                   value: isCompanyChecked,
//                   onChanged: isComapnyOnChanged,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 2),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 isAddText,
//                 style: TextStyleConfig.textStyle(fontSize: 12.sp),
//               ),
//               Obx(
//                 () => Checkbox(
//                   value: isCompanyChecked,
//                   onChanged: isComapnyOnChanged,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 2),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 isEditText,
//                 style: TextStyleConfig.textStyle(fontSize: 12.sp),
//               ),
//               Obx(
//                 () => Checkbox(
//                   value: isCompanyChecked,
//                   onChanged: isComapnyOnChanged,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 2),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 isDeleteText,
//                 style: TextStyleConfig.textStyle(fontSize: 12.sp),
//               ),
//               Obx(
//                 () => Checkbox(
//                   value: isCompanyChecked,
//                   onChanged: isComapnyOnChanged,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//         ],
//       ).commonOnlyPadding(left: 10, right: 10, top: 10, bottom: 10),
//     );
//   }
// }

// class EmployeePermissionContainerModule extends StatelessWidget {
//   final String labelText;
//   final String isViewText;
//   final String isAddText;
//   final String isEditText;
//   final String isDeleteText;
//   final bool isEmployeeChecked;
//   Function(bool?) isEmployeeOnChanged;
//   EmployeePermissionContainerModule({
//     super.key,
//     required this.labelText,
//     required this.isViewText,
//     required this.isAddText,
//     required this.isEditText,
//     required this.isDeleteText,
//     required this.isEmployeeChecked,
//     required this.isEmployeeOnChanged,
//   });
//   final adminPermissionScreenController =
//       Get.find<AdminPermissionScreenController>();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: AppColors.greyColor,
//           width: 2,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             labelText,
//             style: TextStyleConfig.textStyle(
//                 fontSize: 19, fontWeight: FontWeight.bold),
//           ),
//           const Divider(),
//           const SizedBox(height: 2),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 isViewText,
//                 style: TextStyleConfig.textStyle(fontSize: 12.sp),
//               ),
//               Obx(
//                 () => Checkbox(
//                   value: isEmployeeChecked,
//                   onChanged: isEmployeeOnChanged,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 2),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 isAddText,
//                 style: TextStyleConfig.textStyle(fontSize: 12.sp),
//               ),
//               Obx(
//                 () => Checkbox(
//                   value: isEmployeeChecked,
//                   onChanged: isEmployeeOnChanged,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 2),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 isEditText,
//                 style: TextStyleConfig.textStyle(fontSize: 12.sp),
//               ),
//               Obx(
//                 () => Checkbox(
//                   value: isEmployeeChecked,
//                   onChanged: isEmployeeOnChanged,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 2),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 isDeleteText,
//                 style: TextStyleConfig.textStyle(fontSize: 12.sp),
//               ),
//               Obx(
//                 () => Checkbox(
//                   value: isEmployeeChecked,
//                   onChanged: isEmployeeOnChanged,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//         ],
//       ).commonOnlyPadding(left: 10, right: 10, top: 10, bottom: 10),
//     );
//   }
// }

// class SubAdminPermissionContainerModule extends StatelessWidget {
//   final String labelText;
//   final String isViewText;
//   final String isAddText;
//   final String isEditText;
//   final String isDeleteText;
//   final bool isSubAdminChecked;
//   Function(bool?) isSubAdminOnChanged;
//   SubAdminPermissionContainerModule({
//     super.key,
//     required this.labelText,
//     required this.isViewText,
//     required this.isAddText,
//     required this.isEditText,
//     required this.isDeleteText,
//     required this.isSubAdminChecked,
//     required this.isSubAdminOnChanged,
//   });
//   final adminPermissionScreenController =
//       Get.find<AdminPermissionScreenController>();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: AppColors.greyColor,
//           width: 2,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             labelText,
//             style: TextStyleConfig.textStyle(
//                 fontSize: 19, fontWeight: FontWeight.bold),
//           ),
//           const Divider(),
//           const SizedBox(height: 2),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 isViewText,
//                 style: TextStyleConfig.textStyle(fontSize: 12.sp),
//               ),
//               Obx(
//                 () => Checkbox(
//                   value: isSubAdminChecked,
//                   onChanged: isSubAdminOnChanged,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 2),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 isAddText,
//                 style: TextStyleConfig.textStyle(fontSize: 12.sp),
//               ),
//               Obx(
//                 () => Checkbox(
//                     value: isSubAdminChecked, onChanged: isSubAdminOnChanged),
//               ),
//             ],
//           ),
//           const SizedBox(height: 2),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 isEditText,
//                 style: TextStyleConfig.textStyle(fontSize: 12.sp),
//               ),
//               Obx(
//                 () => Checkbox(
//                     value: adminPermissionScreenController
//                         .subAdminIsEditChecked.value,
//                     onChanged: isSubAdminOnChanged),
//               ),
//             ],
//           ),
//           const SizedBox(height: 2),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 isDeleteText,
//                 style: TextStyleConfig.textStyle(fontSize: 12.sp),
//               ),
//               Obx(
//                 () => Checkbox(
//                   value: adminPermissionScreenController
//                       .subAdminIsDeleteChecked.value,
//                   onChanged: isSubAdminOnChanged,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//         ],
//       ).commonOnlyPadding(left: 10, right: 10, top: 10, bottom: 10),
//     );
//   }
// }
