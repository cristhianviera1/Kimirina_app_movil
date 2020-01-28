class RegisterForm{
  String nombre;
  String email;
  String password;
  String edad;
  String genero;
  String provincia;
  RegisterForm({this.nombre,this.email,this.password, this.edad, this.genero, this.provincia});
  Map<String, dynamic> toJson() {
    return {"nombre": nombre, "email": email, "password": password,"edad":edad,"genero":genero,"provincia":provincia};
  }
}