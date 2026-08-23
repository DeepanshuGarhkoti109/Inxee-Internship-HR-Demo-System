// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final Widget? prefix;
  final bool isPass;
  final String? hintText;
  final String? labeltext;
  final TextInputType textInputType;
  final Function()? onpressed;
  TextFieldInput(
      {Key? key,
      required this.textEditingController,
      this.hintText,
      this.labeltext,
      this.isPass = false,
      this.prefix,
      this.onpressed,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final focusedInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 2),
    );
    final enabledInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black54),
    );

    return TextFormField(
      controller: textEditingController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a some values';
        } else
          null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefix,
        labelText: labeltext,
        labelStyle: GoogleFonts.actor(fontSize: 18),
        hintStyle: TextStyle(color: Colors.grey[500]),
        focusedBorder: focusedInputBorder,
        enabledBorder: enabledInputBorder,
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
      onTap: onpressed,
    );
  }
}
