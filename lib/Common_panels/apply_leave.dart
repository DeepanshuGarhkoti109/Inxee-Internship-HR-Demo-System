// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ApplyLeave extends StatefulWidget {
  const ApplyLeave({Key? key}) : super(key: key);

  @override
  State<ApplyLeave> createState() => _ApplyLeaveState();
}

class _ApplyLeaveState extends State<ApplyLeave> {
  final TextEditingController _applicationController = TextEditingController();
  final TextEditingController _applicationTitleController = TextEditingController();

  String _selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String _range = 'Full Day';
  String _rangeCount = '1';

  PickerDateRange _initialSelectedRange = PickerDateRange(
    DateTime.now(),
    DateTime.now(),
  );

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        final range = args.value as PickerDateRange;
        final startDate = range.startDate;
        final endDate = range.endDate ?? range.startDate;

        if (startDate != null && endDate != null) {
          final diff = endDate.difference(startDate).inDays + 1;
          _rangeCount = diff.toString();
          final startStr = DateFormat('dd/MM/yyyy').format(startDate);
          final endStr = DateFormat('dd/MM/yyyy').format(endDate);
          _range = diff == 1 ? startStr : '$startStr - $endStr';
          _selectedDate = startStr;
        }
      }
    });
  }

  Future<void> _submitLeave() async {
    final title = _applicationTitleController.text.trim();
    final reason = _applicationController.text.trim();

    if (title.isEmpty || reason.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a title and description for your leave.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final currentLeaves = prefs.getStringList('mock_leave_list') ?? [];
    final newLeaveEntry = '${DateTime.now().millisecondsSinceEpoch}|Deepanshu Garhkoti|$_selectedDate|$_rangeCount days|$title - $reason|Pending';
    currentLeaves.insert(0, newLeaveEntry);
    await prefs.setStringList('mock_leave_list', currentLeaves);

    if (mounted) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'Application Submitted',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          content: Text(
            'Your leave application for $_rangeCount day(s) has been submitted successfully to HR for review.',
            style: GoogleFonts.poppins(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                setState(() {
                  _applicationTitleController.clear();
                  _applicationController.clear();
                });
              },
              child: Text(
                'OK',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
              'APPLY FOR LEAVE',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Calendar Card
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xffe2e8f0)),
                  ),
                  child: SfDateRangePicker(
                    onSelectionChanged: _onSelectionChanged,
                    selectionMode: DateRangePickerSelectionMode.range,
                    initialSelectedRange: _initialSelectedRange,
                    startRangeSelectionColor: const Color(0xff3b82f6),
                    endRangeSelectionColor: const Color(0xff1d4ed8),
                    rangeSelectionColor: const Color(0xffdbeafe),
                    headerStyle: DateRangePickerHeaderStyle(
                      textStyle: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff1e293b),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Selected Info Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xffe2e8f0)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Selected Range:", style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xff64748b))),
                          Text(_range, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xff1e293b))),
                        ],
                      ),
                      const Divider(height: 20, color: Color(0xffe2e8f0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Days:", style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xff64748b))),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xffeff6ff),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "$_rangeCount Day(s)",
                              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xff3b82f6)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Form Fields
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xffe2e8f0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Leave Application Details",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff1e293b),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _applicationTitleController,
                        decoration: InputDecoration(
                          labelText: 'Reason / Subject (e.g. Sick Leave, Vacation)',
                          labelStyle: GoogleFonts.poppins(fontSize: 13),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _applicationController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Application Details / Explanation',
                          labelStyle: GoogleFonts.poppins(fontSize: 13),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.all(14),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          setState(() {
                            _applicationTitleController.clear();
                            _applicationController.clear();
                          });
                        },
                        child: Text("Clear Form", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: const Color(0xff0f172a),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: _submitLeave,
                        child: Text("Submit Leave Request", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
