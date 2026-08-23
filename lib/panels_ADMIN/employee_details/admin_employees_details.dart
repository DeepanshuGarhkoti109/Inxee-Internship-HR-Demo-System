import 'package:flutter/material.dart';
import 'package:inxee_hr_application/panels_ADMIN/employee_details/add_new_employee.dart';
import 'package:inxee_hr_application/panels_ADMIN/employee_details/employee_admin_profile.dart';
import 'package:inxee_hr_application/panels_ADMIN/navigationbar_admin.dart';

class AdminEmployeesDetailsPage extends StatefulWidget {
  const AdminEmployeesDetailsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminEmployeesDetailsPage> createState() =>
      _AdminEmployeesDetailsPageState();
}

class _AdminEmployeesDetailsPageState extends State<AdminEmployeesDetailsPage> {
  BoxDecoration containerDecoration = BoxDecoration(
    border: Border.all(color: Colors.black38, width: 2),
    borderRadius: BorderRadius.circular(5),
    color: Colors.white,
  );

  List<Employee> _employees = [
    Employee(
      name: 'Deepanshu Garhkoti',
      email: 'johndoe@example.com',
      designation: 'Software Engineer',
      password: '********',
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text('E M P L O Y E E S'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: Icon(Icons.add_box_sharp),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEmployeePage(),
                    ),
                  ).then((employee) {
                    if (employee != null) {
                      setState(() {
                        _employees.add(employee);
                      });
                    }
                  });
                },
              ),
            ),
          ],
        ),
        drawer: NavigationDrawerAdmin(),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ListView.builder(
              itemCount: _employees.length,
              itemBuilder: (BuildContext context, int index) {
                Employee employee = _employees[index];
                return Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                      decoration: containerDecoration,
                      child: ListTile(
                        onTap: () {
                          //push to profile page for
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => employeeToAdminProfilePage(
                                fullName: employee.name,
                                phoneNumber: '1234567890',
                                email: employee.email,
                                address: '123 Main Street',
                                sex: 'Male',
                                dateOfBirth: '1990/01/01',
                                designation: employee.designation,
                                dateOfJoining: '2020/01/01',
                                age: '33',
                              ),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1517423738875-5ce310acd3da?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1970&q=80',
                          ),
                        ),
                        title: Text(
                          employee.name,
                          style: TextStyle(fontSize: 17, color: Colors.black),
                        ),
                        subtitle: Text(
                          employee.designation,
                          style: TextStyle(color: Colors.black),
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
