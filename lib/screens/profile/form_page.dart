import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:kimirina_app/colors/colors.dart';
import 'package:kimirina_app/services/user_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kimirina_app/models/formulario_model.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPage createState() => new _FormPage();
}

class _FormPage extends State<FormPage> {
  ApiService _apiService = ApiService();
  final GlobalKey<FormBuilderState> _formKeyProfile =
      GlobalKey<FormBuilderState>();
  var fechaLlena = DateTime.now();
  String _pregunta1;
  String _pregunta2;
  String _pregunta3;
  String _pregunta4;
  String _pregunta5;
  String _pregunta6;
  List<dynamic> _pregunta7;

  @override
  void initState() {
    super.initState();
  }

  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    Widget buildNextButton(onStepContinue) {
      if (_currentStep < 6) {
        return FlatButton(
          color: naranja,
          child: Text(
            "Siguiente",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: onStepContinue,
        );
      } else if (_currentStep == 6) {
        return FlatButton(
          color: naranja,
          child: Text(
            "Guardar",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            _validateInputs();
            Alert(
    context: context,
    image: Image.asset("assets/images/logoTransparente.png"),
    title: "Datos guardados",
    desc: "Su información se guardo exitosamente",
    buttons: [
      DialogButton(
          color: secondaryColor,
          child: Text(
            "Aceptar",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          onPressed: () {
            Navigator.pop(context);
            
          })
    ],
  ).show();
          },
        );
      }
    }

    Widget buildCancelButton(onStepCancel) {
      if (_currentStep < 1) {
        return FlatButton(
          child: Text(""),
          onPressed: onStepCancel,
        );
      } else {
        return FlatButton(
          child: Text(
            "Atras",
          ),
          onPressed: onStepCancel,
        );
      }
    }

    return Scaffold(
      appBar: new AppBar(
          backgroundColor: naranja,
          leading: new IconButton(
              icon: new Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop())),
      body: Theme(
        data: ThemeData(primaryColor: naranja),
        child: FormBuilder(
          key: _formKeyProfile,
          autovalidate: true,
          child: new Stepper(
            type: StepperType.vertical,
            currentStep: _currentStep,
            onStepTapped: (int step) => setState(() => _currentStep = step),
            onStepContinue: _currentStep < 7
                ? () => setState(() => _currentStep += 1)
                : null,
            onStepCancel: _currentStep > 0
                ? () => setState(() => _currentStep -= 1)
                : null,
            controlsBuilder: (BuildContext context,
                {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
              return Row(
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  buildNextButton(onStepContinue),
                  buildCancelButton(onStepCancel)
                ],
              );
            },
            steps: <Step>[
              new Step(
                title: new Text(''),
                content: Column(
                  children: <Widget>[
                    Text(
                      "¿En los últimos 6 meses se ha hecho la prueba de VIH?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    FormBuilderRadio(
                      onChanged: (value) {
                        _pregunta1 = value;
                        print(_pregunta1);
                      },
                      attribute: "pregunta1",
                      options: [
                        "Si",
                        "No",
                      ]
                          .map((lang) => FormBuilderFieldOption(value: lang))
                          .toList(growable: false),
                    ),
                  ],
                ),
                isActive: _currentStep >= 0,
                state:
                    _currentStep >= 0 ? StepState.complete : StepState.disabled,
              ),
              new Step(
                title: new Text(''),
                content: Column(
                  children: <Widget>[
                    Text(
                      "¿En los últimos 6 meses usted ha tenido, alguna infección de transmisión sexual?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    FormBuilderRadio(
                      attribute: "pregunta2",
                      onChanged: (value) {
                        _pregunta2 = value;
                        print(_pregunta2);
                      },
                      options: [
                        "Si",
                        "No",
                      ]
                          .map((lang) => FormBuilderFieldOption(value: lang))
                          .toList(growable: false),
                    ),
                  ],
                ),
                isActive: _currentStep >= 1,
                state:
                    _currentStep >= 1 ? StepState.complete : StepState.disabled,
              ),
              new Step(
                title: new Text(''),
                content: Column(
                  children: <Widget>[
                    Text(
                      "¿En los últimos 6 meses, ha tenido sexo anal o vaginal sin protección?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    FormBuilderRadio(
                      attribute: "pregunta3",
                      onChanged: (value) {
                        _pregunta3 = value;
                      },
                      options: [
                        "Si",
                        "No",
                      ]
                          .map((lang) => FormBuilderFieldOption(value: lang))
                          .toList(growable: false),
                    ),
                  ],
                ),
                isActive: _currentStep >= 2,
                state:
                    _currentStep >= 2 ? StepState.complete : StepState.disabled,
              ),
              new Step(
                title: new Text(''),
                content: Column(
                  children: <Widget>[
                    Text(
                      "¿En los últimos 6 meses, usted ha tenido una pareja VIH positivo?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    FormBuilderRadio(
                      attribute: "pregunta4",
                      onChanged: (value) {
                        _pregunta4 = value;
                      },
                      options: [
                        "Si",
                        "No",
                      ]
                          .map((lang) => FormBuilderFieldOption(value: lang))
                          .toList(growable: false),
                    ),
                  ],
                ),
                isActive: _currentStep >= 3,
                state:
                    _currentStep >= 3 ? StepState.complete : StepState.disabled,
              ),
              new Step(
                title: new Text(''),
                content: Column(
                  children: <Widget>[
                    Text(
                      "¿Usted utilizó condón, en su última relación sexual?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    FormBuilderRadio(
                      attribute: "pregunta5",
                      onChanged: (value) {
                        _pregunta5 = value;
                      },
                      options: [
                        "Si",
                        "No",
                      ]
                          .map((lang) => FormBuilderFieldOption(value: lang))
                          .toList(growable: false),
                    ),
                  ],
                ),
                isActive: _currentStep >= 4,
                state:
                    _currentStep >= 4 ? StepState.complete : StepState.disabled,
              ),
              new Step(
                title: new Text(''),
                content: Column(
                  children: <Widget>[
                    Text(
                      "¿En los últimos 6 meses ha recibido Transfusiones de sangre?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    FormBuilderRadio(
                      attribute: "pregunta6",
                      onChanged: (value) {
                        _pregunta6 = value;
                      },
                      options: [
                        "Si",
                        "No",
                      ]
                          .map((lang) => FormBuilderFieldOption(value: lang))
                          .toList(growable: false),
                    ),
                  ],
                ),
                isActive: _currentStep >= 5,
                state:
                    _currentStep >= 5 ? StepState.complete : StepState.disabled,
              ),
              new Step(
                title: new Text(''),
                content: Column(
                  children: <Widget>[
                    Text(
                      "De los siguientes servicios que oferta Kimirina ¿Cuál ha utilizado usted?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    FormBuilderCheckboxList(
                      attribute: "pregunta7",
                      onChanged: (value) {
                        _pregunta7 = value;
                      },
                      options: [
                        FormBuilderFieldOption(value: "PrEP"),
                        FormBuilderFieldOption(value: "nPEP"),
                        FormBuilderFieldOption(value: "Atención médica"),
                        FormBuilderFieldOption(value: "ITS"),
                        FormBuilderFieldOption(value: "Prueba rápida de VIH"),
                        FormBuilderFieldOption(value: "Asesoría de pares"),
                      ],
                    ),
                  ],
                ),
                isActive: _currentStep >= 6,
                state:
                    _currentStep >= 6 ? StepState.complete : StepState.disabled,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validateInputs() async {
    if (_formKeyProfile.currentState.saveAndValidate()) {
      print(
          "$_pregunta1\n$_pregunta2\n$_pregunta3\n$_pregunta4\n$_pregunta5\n$_pregunta6\n$_pregunta7");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString("userid");
  
      Formulario formReg = new Formulario(fechaLlena: DateTime.now().toString(),personaLlena: userId, pregunta1: _pregunta1, pregunta2: _pregunta2, pregunta3: _pregunta3, pregunta4: _pregunta4, pregunta5: _pregunta5, pregunta6: _pregunta6, pregunta7: _pregunta7  );
      
      
      _apiService.storeForm(formReg);
      print(_formKeyProfile.currentState.value);
    }
  }
}
