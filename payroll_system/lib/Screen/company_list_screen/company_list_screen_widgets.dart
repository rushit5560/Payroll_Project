import 'package:flutter/material.dart';
import 'package:payroll_system/Utils/extensions.dart';
import 'package:payroll_system/Utils/messaging.dart';
import 'package:payroll_system/Utils/style.dart';
import 'package:payroll_system/constants/colors.dart';

class CompanyListModule extends StatelessWidget {
  const CompanyListModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, i) {
        return companyListTile();
      },
    );
  }

  Widget companyListTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.greyColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              EmployeeListTileCustom(
                textKey: AppMessage.companyName,
                textValue: AppMessage.companyName,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppMessage.companyName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleConfig.textStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      AppMessage.companyName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleConfig.textStyle(),
                    ),
                  ),
                ],
              ).commonSymmetricPadding(vertical: 2),

            ],
          ),
        ),
      ),
    );
  }
}


class EmployeeListTileCustom extends StatelessWidget {
  final String textKey;
  final String textValue;

  const EmployeeListTileCustom(
  {super.key, required this.textValue, required this.textKey});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            textKey,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyleConfig.textStyle(fontWeight: FontWeight.w600),
          ),
        ),
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


