import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'attendance_page.dart';

class HomePage extends StatefulWidget {
  final VoidCallback? onCheckIn;
  final VoidCallback? onCheckOut;

  const HomePage({Key? key, this.onCheckIn, this.onCheckOut}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xffeef444c);
  int slideCount = 0;
  bool showSlideBar = true;
  DateTime? checkInTime;
  DateTime? checkOutTime;
  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    checkSlideCount();
  }

  Future<void> checkSlideCount() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String filePath = '${appDocumentsDirectory.path}/slideData.txt';
    File file = File(filePath);

    if (file.existsSync()) {
      List<String> lines = file.readAsLinesSync();
      if (lines.isNotEmpty) {
        slideCount = int.tryParse(lines[0]) ?? 0;
        if (slideCount == 2) {
          // User has already checked in and checked out for the day
          setState(() {
            showSlideBar = false;
            String? checkInTimeString = lines.length > 1 ? lines[1] : null;
            String? checkOutTimeString = lines.length > 2 ? lines[2] : null;
            if (checkInTimeString != null) {
              checkInTime = DateFormat('HH:mm').parse(checkInTimeString);
            }
            if (checkOutTimeString != null) {
              checkOutTime = DateFormat('HH:mm').parse(checkOutTimeString);
            }
          });
        } else if (slideCount == 1) {
          // User has checked in but not checked out
          setState(() {
            showSlideBar = true;
            String? checkInTimeString = lines.length > 1 ? lines[1] : null;
            if (checkInTimeString != null) {
              checkInTime = DateFormat('HH:mm').parse(checkInTimeString);
            }
          });
        }
      }
    }
  }

  Future<void> saveSlideCount() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String filePath = '${appDocumentsDirectory.path}/slideData.txt';
    File file = File(filePath);

    String checkInTimeString = DateFormat('HH:mm').format(DateTime.now());
    String checkOutTimeString =
        checkOutTime != null ? DateFormat('HH:mm').format(checkOutTime!) : '';

    // Write slide count, check-in time, and check-out time to the file
    await file.writeAsString(
      '$slideCount\n'
      '$checkInTimeString\n'
      '$checkOutTimeString\n',
      mode: FileMode.write,
    );

    if (slideCount == 1 && widget.onCheckIn != null) {
      widget.onCheckIn!();
    } else if (slideCount == 2 && widget.onCheckOut != null) {
      widget.onCheckOut!();
    }
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AttendancePage(
            checkInTime: checkInTime,
            checkOutTime: checkOutTime,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: 500,
      child: Center(
        child: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 32),
                  child: Text(
                    "Welcome",
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: "Schyler",
                      fontSize: screenWidth / 20,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Employee", // +User.username,
                    style: TextStyle(
                      fontFamily: "Trajan Pro",
                      fontSize: screenWidth / 18,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 12, bottom: 32),
                  child: Text(
                    "Today's Status",
                    style: TextStyle(
                      fontFamily: "Trajan Pro",
                      fontSize: screenWidth / 18,
                    ),
                  ),
                ),
                Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(2, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Check In",
                              style: TextStyle(
                                fontFamily: "Schyler",
                                fontSize: screenWidth / 20,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              checkInTime != null
                                  ? DateFormat('HH:mm').format(checkInTime!)
                                  : '--/--',
                              style: TextStyle(
                                fontFamily: "Trajan Pro",
                                fontSize: screenWidth / 18,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Check Out",
                              style: TextStyle(
                                fontFamily: "Schyler",
                                fontSize: screenWidth / 20,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              checkOutTime != null
                                  ? DateFormat('HH:mm').format(checkOutTime!)
                                  : '--/--',
                              style: TextStyle(
                                fontFamily: "Trajan Pro",
                                fontSize: screenWidth / 18,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 8),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              DateFormat('hh:mm:ss a').format(DateTime.now()),
                              style: TextStyle(
                                fontFamily: "Schyler",
                                fontSize: screenWidth / 20,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(top: 4),
                            child: RichText(
                              text: TextSpan(
                                text: currentDate.day.toString(),
                                style: TextStyle(
                                  color: primary,
                                  fontSize: screenWidth / 20,
                                  fontFamily: "Trajan Pro",
                                ),
                                children: [
                                  TextSpan(
                                    text: DateFormat(' MMMM yyyy')
                                        .format(currentDate),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenWidth / 22,
                                      fontFamily: "Trajan Pro",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                showSlideBar
                    ? Container(
                        margin: const EdgeInsets.only(top: 24),
                        child: Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.startToEnd,
                          background: Container(
                            color: primary,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 20),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          ),
                          child: Container(
                            color: Colors.white,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 20),
                            child: Text(
                              slideCount == 0
                                  ? 'Slide To Check In'
                                  : 'Slide To Check Out',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: screenWidth / 20,
                                fontFamily: 'Schyler',
                              ),
                            ),
                          ),
                          onDismissed: (direction) {
                            if (direction == DismissDirection.startToEnd) {
                              setState(() {
                                slideCount++;
                                if (slideCount == 1) {
                                  checkInTime = DateTime.now();
                                  if (widget.onCheckIn != null) {
                                    widget.onCheckIn!();
                                  }
                                } else if (slideCount == 2) {
                                  checkOutTime = DateTime.now();
                                  showSlideBar = false;
                                  print('You Have Completed Your Day');
                                  if (widget.onCheckOut != null) {
                                    widget.onCheckOut!();
                                  }
                                }
                                saveSlideCount(); // Save slide count and times
                              });
                            }
                          },
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'You Have Completed Your Day',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: screenWidth / 20,
                            fontFamily: 'Schyler',
                          ),
                        ),
                      ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AttendancePage(
                          checkInTime: checkInTime,
                          checkOutTime: checkOutTime,
                        ),
                      ),
                    );
                  },
                  child: Text('View Attendance'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
