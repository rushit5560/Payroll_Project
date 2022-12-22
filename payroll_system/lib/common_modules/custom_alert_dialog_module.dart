import 'package:flutter/material.dart';
import 'package:payroll_system/Utils/messaging.dart';
import 'package:payroll_system/Utils/style.dart';

class CustomAlertDialog {
  void showAlertDialog({
    required BuildContext context,
    required Function() onYesTap,
    required Function() onCancelTap,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            AppMessage.deleteAlertMessage,
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
                TextButton(
                  onPressed: onYesTap,
                  child: Text(
                    AppMessage.yes,
                    style: TextStyleConfig.textStyle(
                      textColor: Colors.red,
                      fontSize: 17,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onCancelTap,
                  child: Text(
                    AppMessage.no,
                    style: TextStyleConfig.textStyle(
                      textColor: Colors.red,
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
