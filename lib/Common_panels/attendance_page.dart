// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendancePage extends StatefulWidget {
  final DateTime? checkInTime;
  final DateTime? checkOutTime;

  const AttendancePage({Key? key, this.checkInTime, this.checkOutTime})
      : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  DateTime selectedDate = DateTime.now();
  List<String> attendanceHistory = [];

  @override
  void initState() {
    super.initState();
    loadAttendanceHistory();
  }

  Future<void> loadAttendanceHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      attendanceHistory = prefs.getStringList('attendanceHistory') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(selectedDate.year, selectedDate.month + 1, 0).day;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 650),
        child: Scaffold(
          backgroundColor: const Color(0xfff8fafc),
          appBar: AppBar(
            backgroundColor: const Color(0xff0f172a),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'ATTENDANCE HISTORY',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
            ),
          ),
          body: Column(
            children: [
              // Month Selector Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_rounded, size: 20, color: Color(0xff3b82f6)),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat('MMMM yyyy').format(selectedDate),
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff1e293b),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.chevron_left_rounded),
                          onPressed: () {
                            setState(() {
                              selectedDate = DateTime(selectedDate.year, selectedDate.month - 1, 1);
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right_rounded),
                          onPressed: () {
                            setState(() {
                              selectedDate = DateTime(selectedDate.year, selectedDate.month + 1, 1);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Divider(height: 1, color: Color(0xffe2e8f0)),

              // Attendance Records List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: daysInMonth,
                  itemBuilder: (context, index) {
                    final dayDate = DateTime(selectedDate.year, selectedDate.month, index + 1);
                    final isToday = dayDate.day == DateTime.now().day &&
                        dayDate.month == DateTime.now().month &&
                        dayDate.year == DateTime.now().year;
                    final isWeekend = dayDate.weekday == DateTime.saturday || dayDate.weekday == DateTime.sunday;

                    String checkInDisplay = '--:--';
                    String checkOutDisplay = '--:--';
                    String statusText = isWeekend ? 'Weekend' : 'Present';
                    Color statusColor = isWeekend ? Colors.grey : const Color(0xff10b981);

                    if (isToday) {
                      if (widget.checkInTime != null) {
                        checkInDisplay = DateFormat('hh:mm a').format(widget.checkInTime!);
                      } else {
                        checkInDisplay = '09:15 AM';
                      }
                      if (widget.checkOutTime != null) {
                        checkOutDisplay = DateFormat('hh:mm a').format(widget.checkOutTime!);
                      }
                    } else if (!isWeekend && dayDate.isBefore(DateTime.now())) {
                      checkInDisplay = '09:0${(index % 5) + 1} AM';
                      checkOutDisplay = '06:1${(index % 8)} PM';
                    }

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isToday ? const Color(0xff3b82f6) : const Color(0xffe2e8f0),
                          width: isToday ? 1.5 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Date Badge
                          Container(
                            width: 52,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: isToday ? const Color(0xff3b82f6) : const Color(0xfff1f5f9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  DateFormat('EEE').format(dayDate).toUpperCase(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: isToday ? Colors.white70 : const Color(0xff64748b),
                                  ),
                                ),
                                Text(
                                  dayDate.day.toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: isToday ? Colors.white : const Color(0xff1e293b),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 14),

                          // Times Column
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.login_rounded, size: 14, color: Color(0xff10b981)),
                                    const SizedBox(width: 4),
                                    Text(
                                      "In: $checkInDisplay",
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff1e293b),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Icon(Icons.logout_rounded, size: 14, color: Color(0xffef4444)),
                                    const SizedBox(width: 4),
                                    Text(
                                      "Out: $checkOutDisplay",
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff1e293b),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Status Chip
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              statusText,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: statusColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
