import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Utils/messaging.dart';
import 'package:payroll_system/Utils/style.dart';
import 'package:payroll_system/constants/colors.dart';


class CustomAlertDialog {
  void showAlertDialog({
    required BuildContext context,
    required String textContent,
    required Function() onYesTap,
    required Function() onCancelTap,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.colorLightPurple2,
          title: Text(
            textContent,
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          contentPadding: const EdgeInsets.symmetric(vertical: 40),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          titleTextStyle: TextStyleConfig.textStyle(fontSize: 18),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: onYesTap,
                  child: Text(
                    AppMessage.yes,
                    style: TextStyleConfig.textStyle(
                      textColor: AppColors.colorBlack,
                      fontSize: 17,
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: onCancelTap,
                  style: OutlinedButton.styleFrom(backgroundColor: AppColors.colorBtBlue),
                  child: Text(
                    AppMessage.no,
                    style: TextStyleConfig.textStyle(
                      textColor: AppColors.colorWhite,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class CustomMobileBackPressAlertDialog extends StatelessWidget {
  // String textContent;
  // Function() onYesTap;
  // Function() onCancelTap;

  CustomMobileBackPressAlertDialog({
    Key? key,
    // required String textContent,
    // required Function() onYesTap,
    // required Function() onCancelTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.colorLightPurple2,
      title: Text(
        AppMessage.backAlertMessage,
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      contentPadding: const EdgeInsets.symmetric(vertical: 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      titleTextStyle: TextStyleConfig.textStyle(fontSize: 18),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: Text(
                AppMessage.yes,
                style: TextStyleConfig.textStyle(
                  textColor: AppColors.colorBlack,
                  fontSize: 17,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                Get.back();
              },
              style: OutlinedButton.styleFrom(backgroundColor: AppColors.colorBtBlue),
              child: Text(
                AppMessage.no,
                style: TextStyleConfig.textStyle(
                  textColor: AppColors.colorWhite,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
