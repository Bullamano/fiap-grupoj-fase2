import 'package:flutter/material.dart';
import 'package:need_help/design_system/colors.dart';

class EditableTextField extends StatefulWidget {

  const EditableTextField({
    Key? key,
    required this.tutorialLabelText,
    required this.tutorialHelperText,
    required this.textController,
  }) : super(key: key);

  final String tutorialLabelText;
  final String tutorialHelperText;
  final TextEditingController textController;

  @override
  State<EditableTextField> createState() => _EditableTextFieldState();
}

class _EditableTextFieldState extends State<EditableTextField> {

  @override
  void dispose() {
    widget.textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Material(
            color: Colors.transparent,
            child: TextFormField(
              controller: widget.textController,
              style: TextStyle(color: kAppTextColor),
              cursorColor: kAppAccentColor,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: kAppThemeColor)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: kAppThemeColor)),
                helperText: widget.tutorialHelperText,
                helperStyle: TextStyle(color: kAppHelperTextColor),
                labelText: widget.tutorialLabelText,
                labelStyle: TextStyle(color: kAppThemeColor)
              ),
            ),
          ),
        ),
      ],
    );
  }
}
