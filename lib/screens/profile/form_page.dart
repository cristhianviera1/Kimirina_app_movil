import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:kimirina_app/colors/colors.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPage createState() => new _FormPage();
}

class _FormPage extends State<FormPage> {
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
            Alert(context: context, title: "FIN").show();
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
      }else{
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
        child: new Stepper(
          type: StepperType.vertical,
          currentStep: _currentStep,
          onStepTapped: (int step) => setState(() => _currentStep = step),
          onStepContinue:
              _currentStep < 7 ? () => setState(() => _currentStep += 1) : null,
          onStepCancel:
              _currentStep > 0 ? () => setState(() => _currentStep -= 1) : null,
          controlsBuilder: (BuildContext context,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return Row(
              children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                Container(
                  child: buildNextButton(onStepContinue),
                ),
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
                  FormBuilder(
                    autovalidate: true,
                    child: Column(
                      children: <Widget>[
                        FormBuilderRadio(
                          attribute: "pregunta1",
                          validators: [
                            FormBuilderValidators.required(
                                errorText: "El campo no puede quedar vacío")
                          ],
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
                          validators: [
                            FormBuilderValidators.required(
                                errorText: "El campo no puede quedar vacío")
                          ],
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
                          validators: [
                            FormBuilderValidators.required(
                                errorText: "El campo no puede quedar vacío")
                          ],
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
                          validators: [
                            FormBuilderValidators.required(
                                errorText: "Este campo no puede quedar vacío")
                          ],
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
                          validators: [
                            FormBuilderValidators.required(
                                errorText: "Este campo no puede quedar vacío")
                          ],
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
                          validators: [
                            FormBuilderValidators.required(
                                errorText: "Este campo no puede quedar vacío")
                          ],
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
