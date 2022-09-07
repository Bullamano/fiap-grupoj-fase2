import 'package:flutter/material.dart';

class CustomListTitle extends StatelessWidget {
  const CustomListTitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: ListTile(
          title: Text(
            text,
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
