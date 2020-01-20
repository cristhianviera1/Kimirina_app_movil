import 'package:flutter/material.dart';
import 'dart:ui';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}



Color primaryColor = HexColor("#2D287C");

Color primaryLight = HexColor("#046D8A");
Color primaryDark = HexColor("#102840");

Color secondaryColor = HexColor("#FE405A");

Color secondaryLight = HexColor("#102840");
Color secondaryDark = HexColor("#046D8A");

Color tertyaryColor = HexColor("#FFD15C");


Color naranja = HexColor("#F03506"); //Naranja
Color azul = HexColor("#2D287C"); //Azul
Color verde = HexColor("#1A863D"); // Verde
Color morado = HexColor("#6F005C"); // Morado

const TextStyle estiloBotonesTexto = TextStyle(fontSize: 16);

const Color gradientStart = const Color(0xFFfbab66);
const Color gradientEnd = const Color(0xFFf7418c);

const primaryGradient = const LinearGradient(
  colors: const [gradientStart, gradientEnd],
  stops: const [0.0, 1.0],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const chatBubbleGradient = const LinearGradient(
  colors: const [Color(0xFFFD60A3), Color(0xFFFF8961)],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);

const chatBubbleGradient2 = const LinearGradient(
  colors: const [Color(0xFFf4e3e3), Color(0xFFf4e3e3)],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);

const styleTextQuestions = const TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
);