import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/common_modules/new/single_list_tile_module.dart';
import 'package:payroll_system/constants/colors.dart';
import 'package:payroll_system/controllers/pay_checkes_dowanload_screen_controller.dart';
import 'package:payroll_system/utils/app_images.dart';
import 'package:payroll_system/utils/extensions.dart';
import 'package:payroll_system/utils/messaging.dart';
import 'package:sizer/sizer.dart';

class PayCheckesDowanloadWidgetsListScreen extends StatelessWidget {
  PayCheckesDowanloadWidgetsListScreen({super.key});
  final payCheckesDowanloadScreenController =
      Get.find<PayCheckesDowanloadScreenController>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: payCheckesDowanloadScreenController
            .payCheckesDwanloadListData.length,
        itemBuilder: (context, index) {
          final payrollListDataListvalue = payCheckesDowanloadScreenController
              .payCheckesDwanloadListData[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.colorWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // https://appieve.com/api/admin/payrolldownload/26
                        },
                        child: Image.asset(
                          AppImages.downloadIcon,
                          width: 30,
                          height: 30,
                          color: AppColors.colorBtBlue,
                        ),
                      ),
                    ],
                  ),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.payDate,
                    textValue: payrollListDataListvalue.paydate
                        .toString()
                        .split(" ")[0],
                    image: AppImages.calendarIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.employeeName,
                    textValue: payrollListDataListvalue.firstName +
                        payrollListDataListvalue.middleName +
                        payrollListDataListvalue.lastName,
                    image: AppImages.employeeIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.company,
                    textValue: payrollListDataListvalue.companyname,
                    image: AppImages.companyIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.startDate,
                    textValue: payrollListDataListvalue.startdate
                        .toString()
                        .split(" ")[0],
                    image: AppImages.calendarIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.endDate,
                    textValue: payrollListDataListvalue.enddate
                        .toString()
                        .split(" ")[0],
                    image: AppImages.calendarIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.totalDays,
                    textValue: payrollListDataListvalue.days,
                    image: AppImages.totalDaysIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.payPeriod,
                    textValue: payrollListDataListvalue.payPeriod,
                    image: AppImages.payPeriodIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.hours,
                    textValue: payrollListDataListvalue.type,
                    image: AppImages.hoursIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.salaryHourlyRate,
                    textValue: payrollListDataListvalue.payPeriod == "salary"
                        ? payrollListDataListvalue.salary
                        : payrollListDataListvalue.ragularhour,
                    image: AppImages.salaryIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.subTotal,
                    textValue: payrollListDataListvalue.subTotal,
                    image: AppImages.netAmountIcon,
                  ),
                  const SizedBox(height: 5),
                  SingleListTileModuleCustom(
                    textKey: AppMessage.netAmount,
                    textValue: payrollListDataListvalue.finalAmount,
                    image: AppImages.netAmountIcon,
                  ),
                  SizedBox(height: 2.h),

                  /*Row(
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
                  ),*/
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
    const String url = 'https://www.africau.edu/images/default/sample.pdf';

    const String fileName = "download.pdf";

    String path = await _getFilePath(fileName);

    await dio.download(
      url,
      path,
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

  _getFilePath(String fileName) async {
    // final dir = await getApplicationDocumentsDirectory();
    final dir = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    return "$dir/$fileName";

    // return dir;
  }

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
