class Productos {
  String id;
  String titulo;
  String descripcion;
  String imagen;
  String link;
  String precio;
  String observaciones;

  Productos(
      {this.id,
      this.titulo,
      this.descripcion,
      this.imagen,
      this.link,
      this.precio,
      this.observaciones,
 });

  factory Productos.fromJson(dynamic json) {
    return new Productos(id:json["id"],titulo: json["titulo"]as String, );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "titulo": this.titulo,
      "descripcion": this.descripcion,
      "imagen": this.imagen,
      "link": this.link,
      "precio": this.precio,
      "observaciones": this.observaciones,
      
    };
  }
}