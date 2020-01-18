class User {
  String id;
  String nombre;
  String email;
  String password;
  String imagen;
  String telefono;
  String provincia;
  String rol;
  User({this.id, this.nombre, this.email, this.password,this.provincia,this.rol});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
      password: json['password'],
      provincia: json['provincia'],
    );
  }
  Map<String, dynamic> toJson() {
    return {"id": id, "nombre": nombre, "email": email, "password": password,"provincia":provincia};
  }
  Map toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['nombre'] = nombre;
    map['email'] = email;
    map['password'] = password;
    map['provincia'] = provincia;
    return map;
  }
}
