import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {

  final String labelText, hintText;
  final Color labelColor;
  const CustomField({Key? key, required this.labelText, required this.labelColor, required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(_size.width/20),
        labelText: labelText,
        labelStyle: TextStyle(color: labelColor),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize:18, fontWeight: FontWeight.bold),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: labelColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: labelColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
