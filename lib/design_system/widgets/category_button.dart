import 'package:flutter/material.dart';
import 'package:need_help/design_system/colors.dart';

///Botões de categorias ao topo da tela inicial.
class CategoryButton extends StatelessWidget {
  const CategoryButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Material(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: InkWell(
            onTap: onPressed,
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                color: kAppAccentColor,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}