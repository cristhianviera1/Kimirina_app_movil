class Formulario {
  String id;
  String personaLlena;
  String fechaLlena;
  String pregunta1;
  String pregunta2;
  String pregunta3;
  String pregunta4;
  String pregunta5;
  String pregunta6;
  List<dynamic> pregunta7;
  Formulario(
      {this.id,
      this.personaLlena,
      this.fechaLlena,
      this.pregunta1,
      this.pregunta2,
      this.pregunta3,
      this.pregunta4,
      this.pregunta5,
      this.pregunta6,
      this.pregunta7});

  factory Formulario.fromJson(dynamic json) {
    return new Formulario(id:json["id"],personaLlena: json["nombre"]as String, );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "personaLlena": this.personaLlena,
      "fechaLlena": this.fechaLlena,
      "pregunta1": this.pregunta1,
      "pregunta2": this.pregunta2,
      "pregunta3": this.pregunta3,
      "pregunta4": this.pregunta4,
      "pregunta5": this.pregunta5,
      "pregunta6": this.pregunta6,
      "pregunta7": this.pregunta7,
    };
  }
}