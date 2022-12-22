import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:srm_project/Controller/home_screen.controller.dart';
import 'package:srm_project/Utils/extensions.dart';

import '../../Utils/style.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeScreenController = Get.put(HomeScreenController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.grey.shade400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reshma",
                    style: TextStyleConfig.textStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "reshmakhatrani11@gmail.com",
                    style: TextStyleConfig.textStyle(
                        fontSize: 13.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ).commonOnlyPadding(top: 5.h),
            ),
            GestureDetector(
              onTap: () {},
              child: const ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
              ),
            ),
            // Divider(),
            GestureDetector(
              onTap: () {},
              child: const ListTile(
                leading: Icon(Icons.business_outlined),
                title: Text("Company"),
              ),
            ),
            // Divider(),
            GestureDetector(
              onTap: () {},
              child: const ListTile(
                leading: Icon(Icons.person),
                title: Text("Employe"),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(),
      body: const Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
