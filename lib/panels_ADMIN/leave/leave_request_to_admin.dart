// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplyLeaveToAdmin extends StatefulWidget {
  const ApplyLeaveToAdmin({Key? key}) : super(key: key);

  @override
  State<ApplyLeaveToAdmin> createState() => _ApplyLeaveToAdminState();
}

class _ApplyLeaveToAdminState extends State<ApplyLeaveToAdmin> {
  String _testValues = '28/02/2024';
  String _testrangeCount = '5';
  String _applicationTitleController = 'Leave title';

  static BoxDecoration containerDecoration = BoxDecoration(
    border: Border.all(
      color: Colors.black,
    ),
    borderRadius: BorderRadius.circular(12),
  );

  static BoxDecoration subcontainerDecoration = BoxDecoration(
    border: Border.all(color: Colors.black, width: 10),
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    ),
    color: Colors.black,
  );

  static const TextStyle textStyle =
      TextStyle(fontSize: 16, color: Colors.black);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ListView.separated(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    decoration: containerDecoration,
                    child: Column(
                      children: [
                        Container(
                          decoration: subcontainerDecoration,
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1517423738875-5ce310acd3da?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1970&q=80',
                              ),
                            ),
                            title: Text(
                              'Deepanshu Garhkoti',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            subtitle: Text(
                              'deepanshugarhkoti@gmail.com',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildInfoContainerL('Total Days : 75'),
                            Expanded(child: Container()),
                            _buildInfoContainerR('Total Leave : 75'),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildInfoContainerL('Paid Leave : 05'),
                            Expanded(child: Container()),
                            _buildInfoContainerR('Unpaid Leave : 5'),
                          ],
                        ),
                        const SizedBox(height: 10),
                        buildSelectedInfoContainer(
                          'Selected date: ',
                          // _selectedDate,
                          _testValues,
                        ),
                        const SizedBox(height: 10),
                        buildSelectedInfoContainer(
                          'No. of days: ',
                          _testrangeCount,
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: _applicationForLeave,
                          child: buildSelectedInfoContainer(
                            'Application: ',
                            _applicationTitleController,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Text(
                                'Date : Dateofappli',
                                style: textStyle,
                              ),
                            ),
                            Expanded(child: Container()),
                            submitAndCancelButton(),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          ),
        ),
      );

  Widget _buildInfoContainerR(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, top: 20, bottom: 20),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }

  Widget _buildInfoContainerL(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 20, bottom: 20),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }

  Widget buildSelectedInfoContainer(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              label,
              style: textStyle,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                style: GoogleFonts.actor(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _applicationForLeave() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Application'),
          content: Text(
              'sdasdhckscbsknchsdbxcjkcuidbchabxchjdbxcuvdc bhxbc dcasbcgasvcsah cas cscfsytcsachavschsv  sgvcyts cscv yatscscsctsgc c'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Widget submitAndCancelButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              border: Border.all(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              iconSize: 20,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Cancel Application'),
                      content: Text(
                          'Are you sure you want to cancel the leave application?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                        TextButton(
                          child: Text('Yes'),
                          onPressed: () {
                            //
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(
                Icons.close_sharp,
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              border: Border.all(color: Colors.green, width: 2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              iconSize: 20,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Accept Application'),
                      content: Text(
                          'Are you sure you want to accept the leave application?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                        TextButton(
                          child: Text('Accept'),
                          onPressed: () {
                            //
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(
                Icons.check,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
