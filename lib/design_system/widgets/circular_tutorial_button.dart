import 'package:flutter/material.dart';
import 'package:need_help/design_system/colors.dart';

///Botão para Tutoriais da tela inicial.
///O Widget interno deve ser o retornado pela
///função ImageHelper.circleAvatarBasedOnImage.
class CircularTutorialButton extends StatelessWidget {
  const CircularTutorialButton({
    Key? key,
    required this.innerWidget,
    required this.onPressed,
  }) : super(key: key);

  final Widget innerWidget;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: onPressed,
        child: innerWidget
      ),
    );
  }
}