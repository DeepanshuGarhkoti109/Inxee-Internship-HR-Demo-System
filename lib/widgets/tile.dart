// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final double? height;
  final double? width;
  final String textPrefix;
  const SquareTile({
    super.key,
    this.height,
    this.width,
    required this.textPrefix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      height: height,
      width: width,
      child: Stack(
        children: [
          Text(
            textPrefix,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
