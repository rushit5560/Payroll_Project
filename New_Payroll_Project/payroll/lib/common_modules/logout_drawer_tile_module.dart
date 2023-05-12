import 'package:flutter/material.dart';
import 'package:payroll/constants/colors.dart';
import 'package:payroll/utils/style.dart';

class LogOutDrawerTileModule extends StatelessWidget {
  Function() onTap;
  String title;
  LogOutDrawerTileModule({Key? key, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 1, thickness: 1, indent: 10, endIndent: 10,
              color: AppColors.colorLightPurple2),
          ListTile(
            leading:
            const Icon(Icons.logout_rounded, color: AppColors.colorBtBlue),
            title: Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyleConfig.drawerTextStyle(),
            ),
          ),
          /*Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyleConfig.drawerTextStyle(),
          ).commonSymmetricPadding(horizontal: 10, vertical: 10),*/
          const Divider(height: 1, thickness: 1, indent: 10, endIndent: 10,
          color: AppColors.colorLightPurple2),
        ],
      ),
    );
    /*return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.greyColor,
        ),
      ),

      child: Text(
        AppMessage.companyNameDrawer,
        textAlign: TextAlign.left,
        style: TextStyleConfig.drawerTextStyle(),
      ).commonSymmetricPadding(horizontal: 10, vertical: 5),

    ).commonSymmetricPadding(horizontal: 20, vertical: 10);*/
  }
}