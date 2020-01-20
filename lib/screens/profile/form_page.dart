import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPage createState() => new _FormPage();
}

class _FormPage extends State<FormPage> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop())),
        body: new Stepper(
          type: StepperType.vertical,
          currentStep: _currentStep,
          onStepTapped: (int step) => setState(() => _currentStep = step),
          onStepContinue:
              _currentStep < 4 ? () => setState(() => _currentStep += 1) : null,
          onStepCancel:
              _currentStep > 0 ? () => setState(() => _currentStep -= 1) : null,
          steps: <Step>[
            new Step(
              title: new Text('Datos geográficos'),
              content: new Text('Formulario'),
              isActive: _currentStep >= 0,
              state:
                  _currentStep >= 0 ? StepState.complete : StepState.disabled,
            ),
            new Step(
              title: new Text('Datos personales'),
              content: Column(
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                    autovalidate: true,
                    child: Column(
                      children: <Widget>[
                        FormBuilderTextField(
                          attribute: "Edad",
                          decoration: InputDecoration(labelText: "Edad"),
                          keyboardType: TextInputType.number,
                          validators: [
                            FormBuilderValidators.numeric(),
                            FormBuilderValidators.max(70),
                            (val) {
                              if (val == null || val.isEmpty) {
                                return "Por favor especifique su edad";
                              }
                            }
                          ],
                        ),
                        FormBuilderRadio(
                          decoration: InputDecoration(
                              labelText:
                                  '¿Cuál es su último año de estudios aprobado?'),
                          attribute: "estudiosNivel",
                          validators: [FormBuilderValidators.required()],
                          options: [
                            "Primaria",
                            "Secundaria",
                            "Superior",
                            "Ninguno",
                            "Otro",
                          ]
                              .map(
                                  (lang) => FormBuilderFieldOption(value: lang))
                              .toList(growable: false),
                        ),
                        FormBuilderCheckboxList(
                          decoration: InputDecoration(
                              labelText:
                                  "¿Qué ocupación o trabajo tiene usted?"),
                          attribute: "ocupacion",
                          options: [
                            FormBuilderFieldOption(value: "Empleado/a"),
                            FormBuilderFieldOption(value: "Artesano/a"),
                            FormBuilderFieldOption(value: "Comerciante"),
                            FormBuilderFieldOption(
                                value: "Profesional independiente"),
                            FormBuilderFieldOption(value: "Trabajador sexual"),
                            FormBuilderFieldOption(value: "Estudiante"),
                            FormBuilderFieldOption(value: "Otro"),
                            FormBuilderFieldOption(value: "NR"),
                          ],
                        ),
                        FormBuilderTextField(
                          attribute: "especificarOcupacion",
                          decoration: InputDecoration(
                              labelText:
                                  "Por favor escifique su ocupación o trabajo"),
                          validators: [
                            (val) {
                              if (_fbKey.currentState.fields['ocupacion']
                                          .currentState.value ==
                                      "Otro" &&
                                  (val == null || val.isEmpty))
                                return "Por favor especifique su ocupación";
                            },
                          ],
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
              title: new Text('Historia de las relaciones'),
              content: new Text('Formulario'),
              isActive: _currentStep >= 2,
              state:
                  _currentStep >= 2 ? StepState.complete : StepState.disabled,
            ),
            new Step(
              title: new Text('Referencia para la atención recibida'),
              content: new Text('Formulario'),
              isActive: _currentStep >= 3,
              state:
                  _currentStep >= 3 ? StepState.complete : StepState.disabled,
            ),
            new Step(
              title: new Text('Prueba de VIH'),
              content: new Text('Formulario'),
              isActive: _currentStep >= 4,
              state:
                  _currentStep >= 4 ? StepState.complete : StepState.disabled,
            ),
          ],
        ),
      ),
    );
  }
}
