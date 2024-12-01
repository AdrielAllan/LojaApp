import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  // Inicializa o SizeConfig com o contexto da tela
  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }

  // Obtém a altura proporcional à altura da tela
  static double getProportionateScreenHeight(double inputHeight) {
    // 812 é a altura do layout de design
    double screenHeight = SizeConfig.screenHeight;
    return (inputHeight / 812.0) * screenHeight;
  }

  // Obtém a largura proporcional à largura da tela
  static double getProportionateScreenWidth(double inputWidth) {
    // 375 é a largura do layout de design
    double screenWidth = SizeConfig.screenWidth;
    return (inputWidth / 375.0) * screenWidth;
  }
}
