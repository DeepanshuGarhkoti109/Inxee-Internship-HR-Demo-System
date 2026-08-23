import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'attendance_page.dart';

class HomePage extends StatefulWidget {
  final VoidCallback? onCheckIn;
  final VoidCallback? onCheckOut;

  const HomePage({Key? key, this.onCheckIn, this.onCheckOut}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color primary = const Color(0xff1e293b);
  Color accent = const Color(0xff3b82f6);
  Color successColor = const Color(0xff10b981);
  Color dangerColor = const Color(0xffef4444);

  int slideCount = 0;
  bool showSlideBar = true;
  DateTime? checkInTime;
  DateTime? checkOutTime;
  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    loadSlideData();
  }

  Future<void> loadSlideData() async {
    final prefs = await SharedPreferences.getInstance();
    final todayKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final count = prefs.getInt('slideCount_$todayKey') ?? 0;
    final checkInStr = prefs.getString('checkIn_$todayKey');
    final checkOutStr = prefs.getString('checkOut_$todayKey');

    setState(() {
      slideCount = count;
      if (checkInStr != null && checkInStr.isNotEmpty) {
        checkInTime = DateFormat('HH:mm').parse(checkInStr);
      }
      if (checkOutStr != null && checkOutStr.isNotEmpty) {
        checkOutTime = DateFormat('HH:mm').parse(checkOutStr);
      }
      showSlideBar = slideCount < 2;
    });
  }

  Future<void> saveSlideData() async {
    final prefs = await SharedPreferences.getInstance();
    final todayKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
    await prefs.setInt('slideCount_$todayKey', slideCount);

    if (checkInTime != null) {
      final checkInStr = DateFormat('HH:mm').format(checkInTime!);
      await prefs.setString('checkIn_$todayKey', checkInStr);
    }
    if (checkOutTime != null) {
      final checkOutStr = DateFormat('HH:mm').format(checkOutTime!);
      await prefs.setString('checkOut_$todayKey', checkOutStr);
    }

    if (slideCount == 1 && widget.onCheckIn != null) {
      widget.onCheckIn!();
    } else if (slideCount == 2 && widget.onCheckOut != null) {
      widget.onCheckOut!();
    }
  }

  void handlePunchAction() {
    setState(() {
      slideCount++;
      if (slideCount == 1) {
        checkInTime = DateTime.now();
      } else if (slideCount >= 2) {
        slideCount = 2;
        checkOutTime = DateTime.now();
        showSlideBar = false;
      }
    });
    saveSlideData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Scaffold(
          backgroundColor: const Color(0xfff8fafc),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Welcome Banner Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff1e293b), Color(0xff0f172a)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.blueGrey.shade700,
                        child: const Icon(Icons.person, color: Colors.white, size: 32),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome back,",
                              style: GoogleFonts.poppins(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              "Deepanshu Garhkoti",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Software Engineer Intern • Engineering",
                              style: GoogleFonts.poppins(
                                color: Colors.blue.shade300,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Today's Status Header
                Text(
                  "Today's Attendance Status",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff1e293b),
                  ),
                ),
                const SizedBox(height: 12),

                // Check In / Check Out Card
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xffe2e8f0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Check-In Column
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.login_rounded, size: 18, color: successColor),
                                const SizedBox(width: 6),
                                Text(
                                  "Check In",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff64748b),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              checkInTime != null
                                  ? DateFormat('hh:mm a').format(checkInTime!)
                                  : '--:--',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: checkInTime != null ? successColor : const Color(0xff94a3b8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 1,
                        color: const Color(0xffe2e8f0),
                      ),
                      // Check-Out Column
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.logout_rounded, size: 18, color: dangerColor),
                                const SizedBox(width: 6),
                                Text(
                                  "Check Out",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff64748b),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              checkOutTime != null
                                  ? DateFormat('hh:mm a').format(checkOutTime!)
                                  : '--:--',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: checkOutTime != null ? dangerColor : const Color(0xff94a3b8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Real-time Clock Stream
                StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    final now = DateTime.now();
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xffe2e8f0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.access_time_filled, color: Color(0xff3b82f6), size: 20),
                              const SizedBox(width: 8),
                              Text(
                                DateFormat('hh:mm:ss a').format(now),
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff1e293b),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            DateFormat('EEE, dd MMM yyyy').format(now),
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: const Color(0xff64748b),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),

                // Punch In / Out Interactive Button
                if (showSlideBar)
                  SizedBox(
                    height: 56,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: slideCount == 0 ? accent : dangerColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      onPressed: handlePunchAction,
                      icon: Icon(slideCount == 0 ? Icons.fingerprint : Icons.stop_circle_outlined, size: 24),
                      label: Text(
                        slideCount == 0 ? "PUNCH IN NOW" : "PUNCH OUT NOW",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xffdcfce7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xff86efac)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle, color: Color(0xff166534), size: 22),
                        const SizedBox(width: 10),
                        Text(
                          "You Have Completed Your Day!",
                          style: GoogleFonts.poppins(
                            color: const Color(0xff166534),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 16),

                // View Attendance History Action
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: Color(0xffcbd5e1)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
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
                  icon: const Icon(Icons.calendar_month, color: Color(0xff1e293b)),
                  label: Text(
                    "View Detailed Attendance",
                    style: GoogleFonts.poppins(
                      color: const Color(0xff1e293b),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
