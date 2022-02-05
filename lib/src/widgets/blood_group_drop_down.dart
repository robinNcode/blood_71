import 'package:flutter/material.dart';

class BloodGroupDropDown extends StatelessWidget {
  const BloodGroupDropDown({
    Key? key,
    required this.dropdownvalue,
  }) : super(key: key);

  final String dropdownvalue;
  // List of items in our dropdown menu
  static final List<String> items = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: dropdownvalue,
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (Object? value) {},
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
    );
  }
}
