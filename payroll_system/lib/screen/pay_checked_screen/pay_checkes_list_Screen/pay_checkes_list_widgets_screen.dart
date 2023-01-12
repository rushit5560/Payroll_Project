import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:payroll_system/common_modules/download_button_module.dart';
import 'package:payroll_system/common_modules/single_item_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/pay_checkes_list_screen_controller.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

class PayCheckesListWidgetsScreen extends StatelessWidget {
  PayCheckesListWidgetsScreen({super.key});
  final payCheckesListScreenController =
      Get.find<PayCheckesListScreenController>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: payCheckesListScreenController.payCheckesListData.length,
        itemBuilder: (context, index) {
          final payrollListDataListvalue =
              payCheckesListScreenController.payCheckesListData[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.greyColor,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.date,
                    textValue: payrollListDataListvalue.paydate
                        .toString()
                        .split(" ")[0],
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.name,
                    textValue: payrollListDataListvalue.firstName +
                        payrollListDataListvalue.middleName +
                        payrollListDataListvalue.lastName,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.company,
                    textValue: payrollListDataListvalue.bonus,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.startDate,
                    textValue: payrollListDataListvalue.startdate
                        .toString()
                        .split(" ")[0],
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.endDate,
                    textValue: payrollListDataListvalue.enddate
                        .toString()
                        .split(" ")[0],
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.totalDays,
                    textValue: payrollListDataListvalue.days,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.payPeriod,
                    textValue: payrollListDataListvalue.payPeriod,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.hours,
                    textValue: payrollListDataListvalue.type,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.salaryHourlyRate,
                    textValue: payrollListDataListvalue.salary,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.subTotal,
                    textValue: payrollListDataListvalue.subTotal,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileCustom(
                    textKey: AppMessage.netAmount,
                    textValue: payrollListDataListvalue.finalAmount,
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DownloadButtonModule(
                          onDownloadTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => DownloadDialog());
                          },
                          downloadLabelText: AppMessage.download),
                    ],
                  )
                ],
              ).commonAllSidePadding(10),
            ),
          );
        },
      ),
    );
  }
}

class DownloadDialog extends StatefulWidget {
  const DownloadDialog({super.key});

  @override
  State<DownloadDialog> createState() => _DownloadDialogState();
}

class _DownloadDialogState extends State<DownloadDialog> {
  Dio dio = Dio();
  double progress = 0.0;

  void startDownloading() async {
    const String url =
        'https://firebasestorage.googleapis.com/v0/b/e-commerce-72247.appspot.com/o/195-1950216_led-tv-png-hd-transparent-png.png?alt=media&token=0f8a6dac-1129-4b76-8482-47a6dcc0cd3e';

    // const String fileName = "dowanload files";

    // String path = await _getFilePath(fileName);

    await dio.download(
      url,
      ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS),
      onReceiveProgress: (recivedBytes, totalBytes) {
        log("dowanload files  111");
        setState(() {
          progress = recivedBytes / totalBytes;
        });

        log("progress ::: ${progress}");

        log("dowanload files  222");
      },
      deleteOnError: true,
    ).then((_) {
      Navigator.pop(context);
    });
  }

  // Future<void> _getFilePath() async {
  //   // final dir = await getApplicationDocumentsDirectory();
  //   final dir = await ExternalPath.getExternalStoragePublicDirectory(
  //       ExternalPath.DIRECTORY_DOWNLOADS);
  //   // return "${dir.path}/$filename";

  //   // return
  // }

  @override
  void initState() {
    startDownloading();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String downloadingprogress = (progress * 100).toInt().toString();

    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator.adaptive(),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Downloading: $downloadingprogress%",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
