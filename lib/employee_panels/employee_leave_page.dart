// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:inxee_hr_application/Common_panels/apply_leave.dart';
import 'package:inxee_hr_application/employee_panels/navigationbar_employee.dart';

class EmployeeLeavePanel extends StatefulWidget {
  const EmployeeLeavePanel({super.key});

  @override
  State<EmployeeLeavePanel> createState() => _EmployeeLeavePanelState();
}

class _EmployeeLeavePanelState extends State<EmployeeLeavePanel> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text('L E A V E'),
        ),
        drawer: NavigationDrawerEmployee(),

        //

        body: ApplyLeave(),
      ),
    );
  }
}
