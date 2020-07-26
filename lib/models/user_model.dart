

class User {
  String id;
  String name;
  String email;
  String password;
  String age;
  String gender;
  String image;
  bool online;
  User(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.age,
      this.gender,
      this.image,
      this.online});

  factory User.fromJson(dynamic json) {
    return new User(id:json["id"],name: json["name"]as String, );
  }
  Map toJson() => {
      "id": this.id,
      "name": this.name,
      "email": this.email,
      "password": this.password,
      "age": this.age,
      "gender": this.gender,
      "image": this.image,
      "online": this.online
  };
}
