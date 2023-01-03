import 'package:flutter/material.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/utils/style.dart';

class DrawerListTileModule extends StatelessWidget {
  Function() onTap;
  String title;

  DrawerListTileModule({Key? key, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading:
            const Icon(Icons.person_rounded, color: AppColors.blackColor),
            title: Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyleConfig.drawerTextStyle(),
            ),
          ),
          // Text(
          //   title,
          //   textAlign: TextAlign.left,
          //   style: TextStyleConfig.drawerTextStyle(),
          // ).commonSymmetricPadding(horizontal: 10, vertical: 10),
          const Divider(height: 1, thickness: 1, indent: 10, endIndent: 10),
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