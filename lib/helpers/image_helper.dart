import 'package:flutter/material.dart';
import 'package:need_help/design_system/constants.dart';
import 'package:need_help/design_system/strings.dart';
import 'package:need_help/models/tutorial_item.dart';

///Classe para processamento de imagens a serem adicionadas
///aos itens de tutorial
class ImageHelper {
  ///Método de checagem para uma URL passada em um item de tutorial
  static String checkImageUrl(TutorialItem tutorialItem) {
    if (tutorialItem.urlFoto != null && tutorialItem.urlFoto!.isNotEmpty) {
      return tutorialItem.urlFoto as String;
    }

    return kQuestionMarkUrl;
  }

  ///Método de formatação para o CircleAvatar de um item de tutorial
  static Widget circleAvatarBasedOnImage(TutorialItem tutorialItem) {
    final imageUrl = checkImageUrl(tutorialItem);

    if (imageUrl.isNotEmpty) {
      return CircleAvatar(
        radius: kCircleAvatarRadius,
        backgroundColor: const Color(0x00FFFFFF),
        backgroundImage: NetworkImage(imageUrl),
      );
    }

    return CircleAvatar(
        radius: kCircleAvatarRadius,
        backgroundColor: const Color(0x00FFFFFF),
        child: ClipOval(
          child: Image.asset(
            'assets/images/questionmark.jpg',
          ),
        ));
  }
}
