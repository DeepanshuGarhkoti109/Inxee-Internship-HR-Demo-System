import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminEmployeeCheckInDetails extends StatefulWidget {
  const AdminEmployeeCheckInDetails({super.key});

  @override
  State<AdminEmployeeCheckInDetails> createState() =>
      _AdminEmployeeCheckInDetailsState();
}

class _AdminEmployeeCheckInDetailsState
    extends State<AdminEmployeeCheckInDetails> {
  final List<Map<String, String>> employeesCheckIn = [
    {
      'id': 'EMP001',
      'name': 'Deepanshu Garhkoti',
      'department': 'Engineering',
      'checkIn': '09:15 AM',
      'checkOut': '06:30 PM',
      'status': 'Present',
      'avatar': 'https://images.unsplash.com/photo-1517423738875-5ce310acd3da?auto=format&fit=crop&w=300&q=80',
    },
    {
      'id': 'EMP002',
      'name': 'Rahul Sharma',
      'department': 'Engineering',
      'checkIn': '08:55 AM',
      'checkOut': '06:00 PM',
      'status': 'Present',
      'avatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80',
    },
    {
      'id': 'EMP003',
      'name': 'Priya Patel',
      'department': 'UI/UX Design',
      'checkIn': '09:40 AM',
      'checkOut': '06:15 PM',
      'status': 'Late',
      'avatar': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=300&q=80',
    },
    {
      'id': 'EMP004',
      'name': 'Ananya Verma',
      'department': 'Marketing',
      'checkIn': '--:--',
      'checkOut': '--:--',
      'status': 'On Leave',
      'avatar': 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=300&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Scaffold(
          backgroundColor: const Color(0xfff8fafc),
          appBar: AppBar(
            backgroundColor: const Color(0xff0f172a),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'CHECK-IN DETAILS',
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
                // Quick Summary Cards
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xffe2e8f0)),
                        ),
                        child: Column(
                          children: [
                            Text("Total Staff", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xff64748b))),
                            const SizedBox(height: 4),
                            Text("4", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700, color: const Color(0xff0f172a))),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xffe2e8f0)),
                        ),
                        child: Column(
                          children: [
                            Text("Present Today", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xff64748b))),
                            const SizedBox(height: 4),
                            Text("3", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700, color: const Color(0xff10b981))),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xffe2e8f0)),
                        ),
                        child: Column(
                          children: [
                            Text("On Leave", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xff64748b))),
                            const SizedBox(height: 4),
                            Text("1", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700, color: const Color(0xfff59e0b))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                Text(
                  "Workforce Check-In Logs",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff1e293b),
                  ),
                ),
                const SizedBox(height: 12),

                // Attendance List
                ...employeesCheckIn.map((emp) {
                  final isPresent = emp['status'] == 'Present';
                  final isLate = emp['status'] == 'Late';
                  final badgeColor = isPresent
                      ? const Color(0xff10b981)
                      : (isLate ? const Color(0xfff59e0b) : Colors.grey);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xffe2e8f0)),
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
                        CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(emp['avatar']!),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                emp['name']!,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff1e293b),
                                ),
                              ),
                              Text(
                                "${emp['id']} • ${emp['department']}",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xff64748b),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    "In: ${emp['checkIn']}",
                                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xff10b981)),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    "Out: ${emp['checkOut']}",
                                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xffef4444)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: badgeColor.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            emp['status']!,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: badgeColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
