import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/permission_button_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/screen/role_screens/permission_screens/admin_permission/admin_permission_screen.dart';
import 'package:payroll_system/screen/role_screens/permission_screens/company_permission_screen/company_permission_screen.dart';
import 'package:payroll_system/screen/role_screens/permission_screens/employee_permission_screen/employee_permission_screen.dart';
import 'package:payroll_system/screen/role_screens/permission_screens/sub_admin_permission_screen/sub_admin_permission_screen.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:payroll_system/utils/style.dart';

class AdminPermissionContainer extends StatelessWidget {
  const AdminPermissionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.greyColor,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppMessage.adminText,
            style: TextStyleConfig.textStyle(
              fontSize: 20,
            ),
          ),
          PermissionButtonModule(
            onPermissionTap: () {
              Get.to(() => AdminPermissionScreen());
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
        border: Border.all(
          color: AppColors.greyColor,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppMessage.company,
            style: TextStyleConfig.textStyle(
              fontSize: 20,
            ),
          ),
          PermissionButtonModule(
            onPermissionTap: () {
              Get.to(() => CompanyPermissionScreen());
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
        border: Border.all(
          color: AppColors.greyColor,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppMessage.employee,
            style: TextStyleConfig.textStyle(
              fontSize: 20,
            ),
          ),
          PermissionButtonModule(
            onPermissionTap: () {
              Get.to(() => EmployeePermissionScreen());
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
        border: Border.all(
          color: AppColors.greyColor,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppMessage.subAdminText,
            style: TextStyleConfig.textStyle(
              fontSize: 20,
            ),
          ),
          PermissionButtonModule(
            onPermissionTap: () {
              Get.to(() => SubAdminPermissionScreen());
            },
          ),
        ],
      ).commonSymmetricPadding(horizontal: 15, vertical: 10),
    );
  }
}
