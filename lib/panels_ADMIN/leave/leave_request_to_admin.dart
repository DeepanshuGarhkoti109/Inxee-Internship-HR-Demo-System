// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplyLeaveToAdmin extends StatefulWidget {
  const ApplyLeaveToAdmin({Key? key}) : super(key: key);

  @override
  State<ApplyLeaveToAdmin> createState() => _ApplyLeaveToAdminState();
}

class _ApplyLeaveToAdminState extends State<ApplyLeaveToAdmin> {
  List<Map<String, String>> leaveRequests = [
    {
      'name': 'Deepanshu Garhkoti',
      'email': 'deepanshuGarhkoti@gmail.com',
      'date': '28/08/2026',
      'days': '1 Day',
      'title': 'Personal Emergency Leave',
      'details': 'Need to attend an urgent family commitment and personal errands.',
      'status': 'Pending',
      'avatar': 'https://images.unsplash.com/photo-1517423738875-5ce310acd3da?auto=format&fit=crop&w=300&q=80',
    },
    {
      'name': 'Rahul Sharma',
      'email': 'rahul.sharma@inxee.com',
      'date': '01/09/2026',
      'days': '2 Days',
      'title': 'Medical Checkup & Recovery',
      'details': 'Scheduled routine doctor appointment and medical checkup.',
      'status': 'Pending',
      'avatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80',
    },
    {
      'name': 'Priya Patel',
      'email': 'priya.patel@inxee.com',
      'date': '15/08/2026',
      'days': '1 Day',
      'title': 'Festival Vacation Leave',
      'details': 'Traveling out of station for family festival gathering.',
      'status': 'Approved',
      'avatar': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=300&q=80',
    },
  ];

  @override
  void initState() {
    super.initState();
    loadCustomLeaves();
  }

  Future<void> loadCustomLeaves() async {
    final prefs = await SharedPreferences.getInstance();
    final customList = prefs.getStringList('mock_leave_list') ?? [];
    for (var item in customList) {
      final parts = item.split('|');
      if (parts.length >= 6) {
        leaveRequests.insert(0, {
          'name': parts[1],
          'email': 'deepanshuGarhkoti@gmail.com',
          'date': parts[2],
          'days': parts[3],
          'title': parts[4].split(' - ').first,
          'details': parts[4],
          'status': parts[5],
          'avatar': 'https://images.unsplash.com/photo-1517423738875-5ce310acd3da?auto=format&fit=crop&w=300&q=80',
        });
      }
    }
    setState(() {});
  }

  void updateStatus(int index, String newStatus) {
    setState(() {
      leaveRequests[index]['status'] = newStatus;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Leave request marked as $newStatus'),
        backgroundColor: newStatus == 'Approved' ? const Color(0xff10b981) : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Scaffold(
          backgroundColor: const Color(0xfff8fafc),
          body: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            itemCount: leaveRequests.length,
            itemBuilder: (context, index) {
              final req = leaveRequests[index];
              final isPending = req['status'] == 'Pending';
              final isApproved = req['status'] == 'Approved';

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xffe2e8f0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Employee Header Bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: const BoxDecoration(
                        color: Color(0xff0f172a),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(req['avatar']!),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  req['name']!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  req['email']!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: isApproved
                                  ? const Color(0xff10b981)
                                  : (req['status'] == 'Rejected' ? Colors.red : const Color(0xfff59e0b)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              req['status']!,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Leave Information Content
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "📅 Date: ${req['date']}",
                                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xff1e293b)),
                              ),
                              Text(
                                "Duration: ${req['days']}",
                                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: const Color(0xff64748b)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            req['title']!,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff0f172a),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            req['details']!,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: const Color(0xff475569),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Action Buttons
                          if (isPending)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.red,
                                    side: const BorderSide(color: Colors.red),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  onPressed: () => updateStatus(index, 'Rejected'),
                                  icon: const Icon(Icons.close, size: 16),
                                  label: Text("Reject", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)),
                                ),
                                const SizedBox(width: 12),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff10b981),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  onPressed: () => updateStatus(index, 'Approved'),
                                  icon: const Icon(Icons.check, size: 16),
                                  label: Text("Approve", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
