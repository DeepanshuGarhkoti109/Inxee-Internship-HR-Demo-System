// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inxee_hr_application/Common_panels/salary_page.dart';
import 'package:inxee_hr_application/panels_ADMIN/salary/admin_employee_salary_page.dart';
import 'package:inxee_hr_application/panels_ADMIN/navigationbar_admin.dart';

class AdminSalaryPanel extends StatefulWidget {
  const AdminSalaryPanel({super.key});

  @override
  State<AdminSalaryPanel> createState() => _AdminSalaryPanelState();
}

class _AdminSalaryPanelState extends State<AdminSalaryPanel> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,

        //

        appBar: AppBar(
          backgroundColor: Colors.black,

          centerTitle: true,
          title: Text('S A L A R Y'),

          //

          bottom: TabBar(
            indicatorPadding: EdgeInsets.all(8),
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.values.last,
            tabs: [
              Tab(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Salary',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Text(
                    'Employees',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),

        //
        drawer: NavigationDrawerAdmin(),

        //

        body: TabBarView(
          children: [
            //salary page
            SalaryPage(),

            //
            EmployeeSalaryforAdmin(),
          ],
        ),
      ),
    );
  }
}
