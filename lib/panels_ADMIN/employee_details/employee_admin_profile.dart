// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class employeeToAdminProfilePage extends StatelessWidget {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String address;
  final String sex;
  final String dateOfBirth;
  final String designation;
  final String dateOfJoining;
  final String age;

  employeeToAdminProfilePage({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.sex,
    required this.dateOfBirth,
    required this.designation,
    required this.dateOfJoining,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text('P R O F I L E'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 10),
                CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1438283173091-5dbf5c5a3206?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8ZnVubnl8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60'),
                ),
                SizedBox(height: 15),
                ListTile(
                  leading: Icon(Icons.person_rounded),
                  title: Text('Full Name'),
                  subtitle: Text(fullName),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Phone Number'),
                  subtitle: Text(phoneNumber),
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text('Email'),
                  subtitle: Text(email),
                ),
                ListTile(
                  leading: Icon(Icons.location_on_rounded),
                  title: Text('Address'),
                  subtitle: Text(address),
                ),
                ListTile(
                  leading: Icon(Icons.person_2_outlined),
                  title: Text('Sex'),
                  subtitle: Text(sex),
                ),
                ListTile(
                  leading: Icon(Icons.calendar_month_outlined),
                  title: Text('DOB'),
                  subtitle: Text(dateOfBirth),
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera_front_sharp),
                  title: Text('Designation'),
                  subtitle: Text(designation),
                ),
                ListTile(
                  leading: Icon(Icons.calendar_month_outlined),
                  title: Text('Date of Joining'),
                  subtitle: Text(dateOfJoining),
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today_rounded),
                  title: Text('Age'),
                  subtitle: Text(age),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
