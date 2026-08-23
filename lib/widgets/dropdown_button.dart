// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownButtonWidget extends StatefulWidget {
  final List<String> options;
  final Widget? prefix;
  final double? Length;
  final String? labeltext;

  DropdownButtonWidget({
    Key? key,
    required this.options,
    this.labeltext,
    this.prefix,
    this.Length,
  }) : super(key: key);

  @override
  _DropdownButtonWidgetState createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  String? newValue;

  @override
  Widget build(BuildContext context) {
    final focusedInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 2),
    );
    final enabledInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black54),
    );

    //

    return DropdownButtonHideUnderline(
      child: Container(
        width: widget.Length,
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            prefixIcon: widget.prefix,
            labelText: widget.labeltext,
            labelStyle: GoogleFonts.actor(fontSize: 18),
            hintStyle: TextStyle(color: Colors.grey[500]),
            focusedBorder: focusedInputBorder,
            enabledBorder: enabledInputBorder,
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: EdgeInsets.all(8),
          ),
          dropdownColor: Colors.grey[300],
          icon: Icon(Icons.arrow_drop_down_outlined),
          isExpanded: true,
          elevation: 0,
          value: newValue,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a some values';
            } else
              null;
            return null;
          },
          onChanged: (newValue) {
            setState(() {
              this.newValue = newValue;
            });
          },
          items: widget.options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(fontSize: 18),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
