import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inxee_hr_application/panels_ADMIN/employee_details/admin_employees_details.dart';
import 'package:inxee_hr_application/panels_ADMIN/leave/admin_leave_panel.dart';
import 'package:inxee_hr_application/panels_ADMIN/admin_panel.dart';
import 'package:inxee_hr_application/panels_ADMIN/admin_report_panel.dart';
import 'package:inxee_hr_application/panels_ADMIN/salary/admin_salary_panel.dart';
import 'package:inxee_hr_application/panels_ADMIN/check_in_details.dart';
import 'package:inxee_hr_application/Common_panels/profile_page.dart';

class NavigationDrawerAdmin extends StatelessWidget {
  NavigationDrawerAdmin({super.key});
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    void navigateToAdminProfilePage() {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(),
        ),
      );
    }

    return Drawer(
      width: 275,
      child: Material(
        color: Colors.grey[300],
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            GestureDetector(
              onTap: navigateToAdminProfilePage,
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                accountName: Text('Deepanshu Garhkoti'),
                accountEmail: Text('deepanshuGarhkoti@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      'https://images.unsplash.com/photo-1517423738875-5ce310acd3da?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1970&q=80',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: padding,
              child: buildMenuIteam(
                text: 'Home',
                icon: Icons.home,
                onClicked: () => selectedItem(context, 0),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: padding,
              child: buildMenuIteam(
                text: 'Salary Details',
                icon: Icons.attach_money_outlined,
                onClicked: () => selectedItem(context, 1),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: padding,
              child: buildMenuIteam(
                text: 'Leave Requests',
                icon: Icons.leave_bags_at_home_outlined,
                onClicked: () => selectedItem(context, 2),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: padding,
              child: buildMenuIteam(
                text: 'Check in Details',
                icon: Icons.assignment_turned_in_sharp,
                onClicked: () => selectedItem(context, 3),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: padding,
              child: buildMenuIteam(
                text: 'Employee Details',
                icon: Icons.people,
                onClicked: () => selectedItem(context, 4),
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Divider(color: Colors.black),
            ),
            SizedBox(height: 24),
            Padding(
              padding: padding,
              child: buildMenuIteam(
                text: 'Report',
                icon: Icons.report_gmailerrorred_outlined,
                onClicked: () => selectedItem(context, 5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuIteam({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.black;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
        size: 25,
      ),
      title: Text(
        text,
        style: GoogleFonts.inter(color: color, fontSize: 17),
      ),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AdminPanelHomeScreen(),
          ),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AdminSalaryPanel(),
          ),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AdminLeavePanel(),
          ),
        );
        break;
      case 3:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AdminEmployeeCheckInDetails(),
          ),
        );
        break;
      case 4:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AdminEmployeesDetailsPage(),
          ),
        );
        break;
      case 5:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AdminReportPanel(),
          ),
        );
        break;
      default:
    }
  }
}
