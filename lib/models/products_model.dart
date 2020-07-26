class Product {
  String id;
  String title;
  String description;
  String image;
  String link;
  String price;
  String observations;

  Product(
      {this.id,
      this.title,
      this.description,
      this.image,
      this.link,
      this.price,
      this.observations,
 });

  factory Product.fromJson(dynamic json) {
    return new Product(id:json["id"],title: json["title"]as String, );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "title": this.title,
      "description": this.description,
      "image": this.image,
      "link": this.link,
      "price": this.price,
      "observations": this.observations,
      
    };
  }
}