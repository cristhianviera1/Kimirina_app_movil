import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:kimirina_app/shared/colors.dart';
import 'package:kimirina_app/services/user_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kimirina_app/models/form_model.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPage createState() => new _FormPage();
}

class _FormPage extends State<FormPage> {
  ApiService _apiService = ApiService();
  final GlobalKey<FormBuilderState> _formKeyProfile =
      GlobalKey<FormBuilderState>();
  var namePerson = DateTime.now();
  String _question1;
  String _question2;
  String _question3;
  String _question4;
  String _question5;
  String _question6;
  List<dynamic> _question7;

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
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
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
                        _question1 = value;
                      },
                      attribute: "answer1",
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
                      attribute: "answer2",
                      onChanged: (value) {
                        _question2 = value;
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
                      attribute: "answer3",
                      onChanged: (value) {
                        _question3 = value;
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
                      attribute: "answer4",
                      onChanged: (value) {
                        _question4 = value;
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
                      attribute: "answer5",
                      onChanged: (value) {
                        _question5 = value;
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
                      attribute: "answer6",
                      onChanged: (value) {
                        _question6 = value;
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
                      attribute: "answer7",
                      onChanged: (value) {
                        _question7 = value;
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString("userid");

      FormQuestion formReg = new FormQuestion(
          dateCompleted: DateTime.now().toString(),
          namePerson: userId,
          question1: _question1,
          question2: _question2,
          question3: _question3,
          question4: _question4,
          question5: _question5,
          question6: _question6,
          question7: _question7);

      _apiService.storeForm(formReg);
    }
  }
}
