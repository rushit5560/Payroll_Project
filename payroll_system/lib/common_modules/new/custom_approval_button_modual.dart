import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/style.dart';
import 'package:sizer/sizer.dart';


class ApprovalPaycheckesButtonModule extends StatelessWidget {
  Function() onPress;
  String labelText;
  ApprovalPaycheckesButtonModule({
    Key? key,
    required this.onPress,
    required this.labelText,
  }) : super(key: key);
  // final locationManageScreenController = Get.find<LocationManageScreenController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        // height: 50,
        width: Get.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.colorBtBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              )),
          onPressed: onPress,
          /*onPressed: () async {
            if (locationManageScreenController.formKey.currentState!
                .validate()) {
              if (locationManageScreenController.locationOption ==
                  LocationOption.create) {
                if (locationManageScreenController
                    .selectedValue.value ==
                    AppMessage.chooseOption) {
                  Fluttertoast.showToast(msg: "Please select status");
                } else {
                  await locationManageScreenController
                      .locationCreateFunction();
                }
              } else {
                await locationManageScreenController
                    .locationUpdateFunction();
              }
            }
          },*/
          child: Text(
            labelText,
            style: TextStyleConfig.textStyle(
              textColor: AppColors.whiteColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ).commonSymmetricPadding(vertical: 10),
        ),
      ),
    );
  }
}