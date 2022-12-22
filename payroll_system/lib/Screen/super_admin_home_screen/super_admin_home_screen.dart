import 'package:flutter/material.dart';
import 'package:payroll_system/Utils/messaging.dart';
import 'package:payroll_system/drawer_menu/admin_drawer/admin_drawer.dart';

class SuperAdminHomeScreen extends StatelessWidget {
  const SuperAdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: AdminDrawerMenu(),

      appBar: AppBar(
        centerTitle: true,
        title: Text(AppMessage.adminName),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_rounded),
          ),
        ],
      ),
    );
  }
}
