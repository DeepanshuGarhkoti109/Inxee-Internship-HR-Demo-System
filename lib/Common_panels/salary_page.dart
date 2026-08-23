// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';

class SalaryPage extends StatefulWidget {
  const SalaryPage({super.key});

  @override
  State<SalaryPage> createState() => _SalaryPageState();
}

class _SalaryPageState extends State<SalaryPage> {
  static BoxDecoration containerDecoration = BoxDecoration(
    border: Border.all(
      color: Colors.black,
    ),
    borderRadius: BorderRadius.circular(12),
  );

  static const TextStyle textStyle =
      TextStyle(fontSize: 16, color: Colors.black);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.separated(
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    decoration: containerDecoration,
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
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
                            _buildInfoContainerR('+ Rs 30000'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildInfoContainerL('Leaves : '),
                            Expanded(child: Container()),
                            _buildInfoContainerR('- Rs 1500'),
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
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                Expanded(child: Container()),
                                Text(
                                  '+ Rs 28500',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
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

  String _getFormattedMonth(DateTime dateTime) {
    return '${dateTime.month}/${dateTime.year}';
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
