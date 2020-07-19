import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kimirina_app/models/carrusel_model.dart';
import 'package:kimirina_app/shared/colors.dart';

final carruselPages = <CarruselSlide>[
  CarruselSlide(
      title: Text(
        'Kimirina',
        style: new TextStyle(
            fontSize: 60.0,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..shader = LinearGradient(
                colors: <Color>[Colors.red, Colors.orange],
              ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
      ),
      subTitle: 'Una Oportunidad de Vida',
      bubbleBackground: naranja,
      mainImage: Image.asset('assets/gif/kimirina_logo.gif')),
  CarruselSlide(
    title: Text('Confidencialidad'),
    subTitle:
        'Kimirina respeta y valora la confianza con nuestra corporación brindando la seguridad de la privacidad de la información de cada usuario',
    bubbleBackground: morado,
    mainImage: FlareActor("assets/animations/Lock_Animation.flr",
        alignment: Alignment.topCenter,
        fit: BoxFit.fitWidth,
        animation: "Untitled"),
  ),
  CarruselSlide(
    title: Text('Confianza'),
    subTitle:
        'Kimirina con más de 20 años de experiencia es la primera corporación Ecuatoriana especializada en el VIH',
    bubbleBackground: azul,
    mainImage: FlareActor('assets/animations/handShake.flr',
        alignment: Alignment.center,
        fit: BoxFit.fitWidth,
        animation: "Untitled"),
  ),
  CarruselSlide(
      title: Text('Kimirina Inclusiva'),
      subTitle:
          'Nuestras políticas se adaptan basadas en la importancia de caminar juntos hacia un norte que asegura la justicia y la equidad entre hombres, mujeres y toda su diversidad',
      bubbleBackground: verde,
      mainImage: Image.asset('assets/images/sinDiscriminacion.png',
          fit: BoxFit.fitWidth, alignment: Alignment.center)),
];
