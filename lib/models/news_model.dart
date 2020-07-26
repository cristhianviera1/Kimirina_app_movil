class News {
  String id;
  String title;
  String description;
  String image;
  String datePublication;
  String link;

  News(
      {this.id,
      this.title,
      this.description,
      this.image,
      this.datePublication,
      this.link,
 });

  factory News.fromJson(dynamic json) {
    return new News(id:json["id"],title: json["titulo"]as String, );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "title": this.title,
      "description": this.description,
      "image": this.image,
      "datePublication": this.datePublication,
      "link": this.link,
    };
  }
}