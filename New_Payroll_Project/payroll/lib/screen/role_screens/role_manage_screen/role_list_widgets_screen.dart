import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll/common_modules/permission_button_module.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/screen/role_screens/permission_screens/admin_permission/admin_permission_screen.dart';
import 'package:payroll/screen/role_screens/permission_screens/company_permission_screen/company_permission_screen.dart';
import 'package:payroll/screen/role_screens/permission_screens/employee_permission_screen/employee_permission_screen.dart';
import 'package:payroll/screen/role_screens/permission_screens/sub_admin_permission_screen/sub_admin_permission_screen.dart';
import 'package:payroll/utils/app_images.dart';
import 'package:payroll/utils/extensions.dart';
import 'package:payroll/utils/messaging.dart';
import 'package:payroll/utils/style.dart';

class AdminPermissionContainer extends StatelessWidget {
  const AdminPermissionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            AppImages.companyIcon,
            width: 20,
            height: 20,
          ).commonOnlyPadding(right: 8),
          Expanded(
            child: Text(
              AppMessage.adminText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyleConfig.textStyle(
                fontSize: 20,
              ),
            ),
          ),
          PermissionButtonModule(
            onPermissionTap: () {
              Get.to(() => AdminPermissionScreen(), arguments: ["1"]);
            },
          ),
        ],
      ).commonSymmetricPadding(horizontal: 15, vertical: 10),
    );
  }
}

class CompanyPermissionContainer extends StatelessWidget {
  const CompanyPermissionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            AppImages.companyIcon,
            width: 20,
            height: 20,
          ).commonOnlyPadding(right: 8),
          Expanded(
            child: Text(
              AppMessage.company,
              style: TextStyleConfig.textStyle(
                fontSize: 20,
              ),
            ),
          ),
          PermissionButtonModule(
            onPermissionTap: () {
              Get.to(() => CompanyPermissionScreen(), arguments: ["3"]);
            },
          ),
        ],
      ).commonSymmetricPadding(horizontal: 15, vertical: 10),
    );
  }
}

class EmployeePermissionContainer extends StatelessWidget {
  const EmployeePermissionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            AppImages.employeeIcon,
            width: 20,
            height: 20,
          ).commonOnlyPadding(right: 8),
          Expanded(
            child: Text(
              AppMessage.employee,
              style: TextStyleConfig.textStyle(
                fontSize: 20,
              ),
            ),
          ),
          PermissionButtonModule(
            onPermissionTap: () {
              Get.to(() => EmployeePermissionScreen(), arguments: ["4"]);
            },
          ),
        ],
      ).commonSymmetricPadding(horizontal: 15, vertical: 10),
    );
  }
}

class SubAdminPermissionContainer extends StatelessWidget {
  const SubAdminPermissionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            AppImages.companyIcon,
            width: 20,
            height: 20,
          ).commonOnlyPadding(right: 8),
          Expanded(
            child: Text(
              AppMessage.subAdminText,
              style: TextStyleConfig.textStyle(
                fontSize: 20,
              ),
            ),
          ),
          PermissionButtonModule(
            onPermissionTap: () {
              Get.to(() => SubAdminPermissionScreen(), arguments: ["2"]);
            },
          ),
        ],
      ).commonSymmetricPadding(horizontal: 15, vertical: 10),
    );
  }
}
