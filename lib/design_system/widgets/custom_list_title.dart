import 'package:flutter/material.dart';

class CustomListTitle extends StatelessWidget{

  const CustomListTitle({
    required this.text,});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        title: Text(text,
          style: TextStyle(fontSize: 30)
          , textAlign: TextAlign.left,),
      ),
    );
  }
}