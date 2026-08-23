// ignore_for_file: unnecessary_string_interpolations, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';

import '../../database/sakary_details.dart';

class addEmployeeSalaryAdminPage extends StatefulWidget {
  const addEmployeeSalaryAdminPage({super.key});

  @override
  State<addEmployeeSalaryAdminPage> createState() =>
      _addEmployeeSalaryAdminPageState();
}

class _addEmployeeSalaryAdminPageState
    extends State<addEmployeeSalaryAdminPage> {
  TextEditingController _totalSalaryController = TextEditingController();
  TextEditingController _leaveAmountController = TextEditingController();
  double netTotal = 0.0;

  @override
  void dispose() {
    _totalSalaryController.dispose();
    _leaveAmountController.dispose();
    super.dispose();
  }

  void updateNetTotal() {
    final totalSalary = double.tryParse(_totalSalaryController.text) ?? 0.0;
    final leaveAmount = double.tryParse(_leaveAmountController.text) ?? 0.0;
    setState(() {
      netTotal = totalSalary - leaveAmount;
    });
  }

  static BoxDecoration containerDecoration = BoxDecoration(
    border: Border.all(
      color: Colors.black,
    ),
    borderRadius: BorderRadius.circular(12),
  );

  static const TextStyle textStyle =
      TextStyle(fontSize: 16, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text('E M P L O Y E E   S A L A R Y'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 10),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: Colors.black,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  '${_getFormattedMonth(DateTime.now())}', // Modify this line
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildInfoContainerL('Total Leave : '),
                Expanded(child: Container()),
                _buildInfoContainerR('5'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildInfoContainerL('Paid Leave : '),
                Expanded(child: Container()),
                _buildInfoContainerR('2'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildInfoContainerL('Unpaid Leave : '),
                Expanded(child: Container()),
                _buildInfoContainerR('3'),
              ],
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Divider(color: Colors.black),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildInfoContainerL('Total Salary : '),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text('+ Rs ', style: textStyle),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0, top: 20),
                  child: Container(
                    width: 60,
                    child: TextFormField(
                      onChanged: (_) => updateNetTotal(),
                      controller: _totalSalaryController,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildInfoContainerL('Leaves : '),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text('- Rs  ', style: textStyle),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0, top: 20),
                  child: Container(
                    width: 50,
                    child: TextFormField(
                      onChanged: (_) => updateNetTotal(),
                      controller: _leaveAmountController,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 10),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.black,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Text(
                      'Net Total: ',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Expanded(child: Container()),
                    Text(
                      '+ Rs ${netTotal.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        elevation: 0,
        onPressed: () {
          final totalSalary = _totalSalaryController.text;
          final leaveAmount = _leaveAmountController.text;
          final netSalary =
              (double.parse(totalSalary) - double.parse(leaveAmount))
                  .toString();

          final salaryDetails =
              SalaryDetails(totalSalary, leaveAmount, netSalary);

          Navigator.pop(context, salaryDetails);
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  String _getFormattedMonth(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  Widget _buildInfoContainerR(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, top: 20),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }

  Widget _buildInfoContainerL(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 20),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
