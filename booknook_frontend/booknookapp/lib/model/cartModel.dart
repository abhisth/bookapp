class CartModel {
  CartModel({
    this.id,
    this.name,
    this.author,
    this.description,
    this.category,
    this.price,
    this.image,
  });

  String? id;
  String? author;
  String? name;
  String? description;
  String? category;
  dynamic price;
  String? image;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["_id"],
        author: json["author"],
        name: json["name"],
        description: json["description"],
        category: json["category"],
        price: json["price"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "author" : author,
        "name": name,
        "description": description,
        "category": category,
        "price": price,
        "image": image,
      };
}
