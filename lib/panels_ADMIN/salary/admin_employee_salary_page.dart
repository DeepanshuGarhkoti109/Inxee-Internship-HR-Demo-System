// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../employee_details/add_new_employee.dart';
import '../employee_details/employee_admin_profile.dart';
import 'employee_salary_details.dart';
import '../navigationbar_admin.dart';

class EmployeeSalaryforAdmin extends StatefulWidget {
  const EmployeeSalaryforAdmin({super.key});

  @override
  State<EmployeeSalaryforAdmin> createState() => _EmployeeSalaryforAdminState();
}

class _EmployeeSalaryforAdminState extends State<EmployeeSalaryforAdmin> {
  BoxDecoration containerDecoration = BoxDecoration(
    border: Border.all(color: Colors.black38, width: 2),
    borderRadius: BorderRadius.circular(5),
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavigationDrawerAdmin(),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ListView.builder(
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                      decoration: containerDecoration,
                      child: ListTile(
                        title: Text(
                          'Deepanshu Garhkoti',
                          style: TextStyle(fontSize: 17, color: Colors.black),
                        ),
                        subtitle: Text(
                          'Software Developer',
                          style: TextStyle(color: Colors.black),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    employeeToAdminSalaryPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10)
                  ],
                );
              }),
        ),
      );
}
