import 'package:flutter/material.dart';
import 'package:kimirina_app/colors/colors.dart';
import 'dart:ui';



class YesTreatment extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: azul,
          ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                margin: const EdgeInsets.all(48.0),
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10.0)
                ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset('assets/images/imgSeccion_13.png'),
                      const SizedBox(height: 10.0),
                      Text("Felicidades", style: TextStyle(
                        color: Colors.deepOrange.shade700,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold
                      ),),
                      const SizedBox(height: 20.0),
                      Text("¡Nos alegra que estes en tratamiento!", textAlign: TextAlign.center, style: TextStyle(
                        fontSize: 18.0
                      )),
                      const SizedBox(height: 30.0),

                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 0,
                          highlightElevation: 0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          child: Text("Servicios Kimirina"),
                          onPressed: (){
                            Navigator.pop(context);
                          }
                        ),
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}