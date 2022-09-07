import 'package:flutter/material.dart';
import 'package:need_help/design_system/colors.dart';

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
      color: kAppAccentColor,
      borderRadius: BorderRadius.circular(1000),
      elevation: 2,
      child: Material(
        color: Colors.transparent,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: ListTile(
            onTap: onPressed,
            title: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kAppTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }}