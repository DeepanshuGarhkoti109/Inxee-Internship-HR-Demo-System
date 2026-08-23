// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inxee_hr_application/Common_panels/apply_leave.dart';
import 'package:inxee_hr_application/panels_ADMIN/leave/leave_request_to_admin.dart';
import 'package:inxee_hr_application/panels_ADMIN/navigationbar_admin.dart';

class AdminLeavePanel extends StatefulWidget {
  const AdminLeavePanel({super.key});

  @override
  State<AdminLeavePanel> createState() => _AdminLeavePanelState();
}

class _AdminLeavePanelState extends State<AdminLeavePanel> {
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
          bottom: TabBar(
            indicatorPadding: EdgeInsets.all(8),
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.values.last,
            tabs: [
              Tab(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Leave',
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
                    'Leave Request',
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
        drawer: NavigationDrawerAdmin(),

        //

        body: TabBarView(
          children: [
            //home tab
            ApplyLeave(),

            //attendance tab
            ApplyLeaveToAdmin(),
          ],
        ),
      ),
    );
  }
}
