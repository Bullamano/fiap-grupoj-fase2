import 'package:flutter/material.dart';

class SaveRoundedButton extends StatelessWidget {
  const SaveRoundedButton({
    required this.text,
    required this.onPressed,
});
  
  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(1000),
      elevation: 8,
      child: ListTile(
        onTap: onPressed,
        title: Text(
          text,
          style: TextStyle(
            color: Colors.lightGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }}