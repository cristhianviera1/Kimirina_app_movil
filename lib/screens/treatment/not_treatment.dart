import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:kimirina_app/routes/routes.dart';
class NoTreatment extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromRGBO(45, 40, 124, 1),
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
                      Image.asset('assets/images/notratamiento.png'),
                      const SizedBox(height: 10.0),
                      Text("¿Por qué?", style: TextStyle(
                        color: Colors.deepOrange.shade700,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold
                      ),),
                      const SizedBox(height: 20.0),
                      Text("¿Deseas contancar con un brigadista?", textAlign: TextAlign.center, style: TextStyle(
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
                          child: Text("Contáctanos"),
                          onPressed: () => Navigator.of(context).pushNamed(chatDetailViewRoute),
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