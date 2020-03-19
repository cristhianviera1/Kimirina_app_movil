import 'dart:io';

class User {
  String id;
  String nombre;
  String correo;
  String password;
  String edad;
  String genero;
  File imagen;
  bool online;
  User(
      {this.id,
      this.nombre,
      this.correo,
      this.password,
      this.edad,
      this.genero,
      this.imagen,
      this.online});

  factory User.fromJson(dynamic json) {
    return new User(id:json["id"],nombre: json["nombre"]as String, );
  }
  Map toJson() => {
      "id": this.id,
      "nombre": this.nombre,
      "correo": this.correo,
      "password": this.password,
      "edad": this.edad,
      "genero": this.genero,
      "imagen": this.imagen,
      "online": this.online
  };
}
