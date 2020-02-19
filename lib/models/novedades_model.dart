class Novedades {
  String id;
  String titulo;
  String descripcion;
  String imagen;
  String fechaPublicacion;
  String link;

  Novedades(
      {this.id,
      this.titulo,
      this.descripcion,
      this.imagen,
      this.fechaPublicacion,
      this.link,
 });

  factory Novedades.fromJson(dynamic json) {
    return new Novedades(id:json["id"],titulo: json["titulo"]as String, );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "titulo": this.titulo,
      "descripcion": this.descripcion,
      "imagen": this.imagen,
      "fechaPublicacion": this.fechaPublicacion,
      "link": this.link,
    };
  }
}