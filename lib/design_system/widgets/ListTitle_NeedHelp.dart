import 'package:flutter/material.dart';

class ListTitle_NeedHelp extends StatelessWidget{

  const ListTitle_NeedHelp({
    required this.text,});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.lightGreen,
      child: ListTile(
        title: Text(text,
          style: TextStyle(fontSize: 30)
          , textAlign: TextAlign.left,),
      ),
    );
  }
}