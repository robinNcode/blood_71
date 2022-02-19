import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String header;
  final IconData customIcon;
  const CustomHeader({Key? key, required this.header, required this.customIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(customIcon, color: Colors.blue, size: 22),
        const SizedBox(width: 5),
        Text(
          header,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.blue
          ),
        ),
      ]
    );
  }
}
