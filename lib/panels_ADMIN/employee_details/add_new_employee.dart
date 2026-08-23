// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:inxee_hr_application/widgets/text_field_input.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({super.key});

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _designationController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  List<Employee> _employees = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text('E M P L O Y E E S'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey, //form
              child: Column(
                children: [
                  SizedBox(height: 25),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Add Employee ',
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      SizedBox(height: 25.0),

                      TextFieldInput(
                        labeltext: 'Full Name',
                        textEditingController: _nameController,
                        textInputType: TextInputType.name,
                        prefix: Icon(Icons.person_rounded),
                      ),
                      SizedBox(height: 10.0),
                      TextFieldInput(
                        labeltext: 'Email',
                        textEditingController: _emailController,
                        textInputType: TextInputType.emailAddress,
                        prefix: Icon(Icons.email),
                      ),
                      SizedBox(height: 10.0),
                      TextFieldInput(
                        labeltext: 'Designation',
                        textEditingController: _designationController,
                        textInputType: TextInputType.text,
                        prefix: Icon(Icons.photo_camera_front_sharp),
                      ),
                      SizedBox(height: 10.0),
                      TextFieldInput(
                        labeltext: 'Password',
                        textEditingController: _passwordController,
                        textInputType: TextInputType.text,
                        prefix: Icon(Icons.password),
                      ),
                      SizedBox(height: 10.0),

                      TextFieldInput(
                        labeltext: 'Confirm Password',
                        textEditingController: _confirmPasswordController,
                        textInputType: TextInputType.text,
                        prefix: Icon(Icons.password),
                      ),

                      //
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        elevation: 0,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Validation successful, add employee
            final employee = Employee(
              name: _nameController.text,
              email: _emailController.text,
              designation: _designationController.text,
              password: _passwordController.text,
            );
            _employees.add(employee);

            // Clear the form fields
            _nameController.clear();
            _emailController.clear();
            _designationController.clear();
            _passwordController.clear();
            _confirmPasswordController.clear();

            // Show a dialog or snackbar indicating successful addition
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Success'),
                  content: const Text('Employee added successfully.'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class Employee {
  final String name;
  final String email;
  final String designation;
  final String password;

  Employee({
    required this.name,
    required this.email,
    required this.designation,
    required this.password,
  });
}
