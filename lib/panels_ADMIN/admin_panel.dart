// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inxee_hr_application/Common_panels/home_screen.dart';
import 'package:inxee_hr_application/Common_panels/attendance_page.dart';
import 'package:inxee_hr_application/panels_ADMIN/navigationbar_admin.dart';

class AdminPanelHomeScreen extends StatefulWidget {
  const AdminPanelHomeScreen({super.key});

  @override
  State<AdminPanelHomeScreen> createState() => _AdminPanelHomeScreenState();
}

class _AdminPanelHomeScreenState extends State<AdminPanelHomeScreen> {
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
          title: Text('A D M I N   P A N E L'),

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
                    'Home',
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
                    'Attendance',
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
            //home tab
            HomePage(),

            //attendance tab
            AttendancePage(),
          ],
        ),
      ),
    );
  }
}
