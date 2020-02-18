import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:kimirina_app/colors/colors.dart';
import 'package:flutter/services.dart';
import 'package:kimirina_app/services/user_service.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPage createState() => new _FormPage();
}

class _FormPage extends State<FormPage> {
  ApiService _apiService = ApiService();
  FocusNode focusNode1;
  FocusNode focusNode2;
  FocusNode focusNode3;
  FocusNode focusNode4;
  FocusNode focusNode5;
  FocusNode focusNode6;
  FocusNode focusNode7;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _pregunta1;
  String _pregunta2;
  String _pregunta3;
  String _pregunta4;
  String _pregunta5;
  String _pregunta6;
  String _pregunta7;
  
  @override
  void initState() {
    super.initState();

    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    focusNode4 = FocusNode();
    focusNode5 = FocusNode();
    focusNode6 = FocusNode();
    focusNode7 = FocusNode();
  }
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
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
        child: new Stepper(
          type: StepperType.vertical,
          currentStep: _currentStep,
          onStepTapped: (int step) => setState(() => _currentStep = step),
          onStepContinue:
              _currentStep < 6 ? () => setState(() => _currentStep += 1) : null,
          onStepCancel:
              _currentStep > 0 ? () => setState(() => _currentStep -= 1) : null,
          steps: <Step>[
            new Step(
              title: new Text(''),
              content: Column(
                children: <Widget>[
                  Text(
                    "¿En los últimos 6 meses se ha hecho la prueba de VIH?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  FormBuilder(
                    autovalidate: true,
                    child: Column(
                      children: <Widget>[
                        FormBuilderRadio(
                          attribute: "pregunta1",
                          validators: [FormBuilderValidators.required()],
                          options: [
                            "Si",
                            "No",
                          ]
                              .map(
                                  (lang) => FormBuilderFieldOption(value: lang))
                              .toList(growable: false),
                        ),
                      ],
                    ),
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
                  FormBuilder(
                    autovalidate: true,
                    child: Column(
                      children: <Widget>[
                        FormBuilderRadio(
                          attribute: "pregunta2",
                          validators: [FormBuilderValidators.required()],
                          options: [
                            "Si",
                            "No",
                          ]
                              .map(
                                  (lang) => FormBuilderFieldOption(value: lang))
                              .toList(growable: false),
                        ),
                      ],
                    ),
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
                  FormBuilder(
                    autovalidate: true,
                    child: Column(
                      children: <Widget>[
                        FormBuilderRadio(
                          attribute: "pregunta3",
                          validators: [FormBuilderValidators.required()],
                          options: [
                            "Si",
                            "No",
                          ]
                              .map(
                                  (lang) => FormBuilderFieldOption(value: lang))
                              .toList(growable: false),
                        ),
                      ],
                    ),
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
                  FormBuilder(
                    autovalidate: true,
                    child: Column(
                      children: <Widget>[
                        FormBuilderRadio(
                          attribute: "pregunta4",
                          validators: [FormBuilderValidators.required()],
                          options: [
                            "Si",
                            "No",
                          ]
                              .map(
                                  (lang) => FormBuilderFieldOption(value: lang))
                              .toList(growable: false),
                        ),
                      ],
                    ),
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
                  FormBuilder(
                    autovalidate: true,
                    child: Column(
                      children: <Widget>[
                        FormBuilderRadio(
                          attribute: "pregunta5",
                          validators: [FormBuilderValidators.required()],
                          options: [
                            "Si",
                            "No",
                          ]
                              .map(
                                  (lang) => FormBuilderFieldOption(value: lang))
                              .toList(growable: false),
                        ),
                      ],
                    ),
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
                  FormBuilder(
                    autovalidate: true,
                    child: Column(
                      children: <Widget>[
                        FormBuilderRadio(
                          attribute: "pregunta6",
                          validators: [FormBuilderValidators.required()],
                          options: [
                            "Si",
                            "No",
                          ]
                              .map(
                                  (lang) => FormBuilderFieldOption(value: lang))
                              .toList(growable: false),
                        ),
                      ],
                    ),
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
                  FormBuilder(
                    autovalidate: true,
                    child: Column(
                      children: <Widget>[
                        FormBuilderCheckboxList(
                          attribute: "pregunta7",
                          options: [
                            FormBuilderFieldOption(value: "PrEP"),
                            FormBuilderFieldOption(value: "nPEP"),
                            FormBuilderFieldOption(value: "Atención médica"),
                            FormBuilderFieldOption(value: "ITS"),
                            FormBuilderFieldOption(
                                value: "Prueba rápida de VIH"),
                            FormBuilderFieldOption(value: "Asesoría de pares"),
                          ],
                        ),
                      ],
                    ),
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
    );
  }
}
