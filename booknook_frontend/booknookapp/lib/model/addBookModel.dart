class AddProductModel {
  AddProductModel({
    this.name,
    this.author,
    this.description,
    this.category,
    this.price,
  });

  String? name;
  String? author;
  String? description;
  String? category;
  dynamic price;

  factory AddProductModel.fromJson(Map<String, dynamic> json) =>
      AddProductModel(
        name: json["name"],
        author: json["name"],
        description: json["description"],
        category: json["category"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "author": author,
        "description": description,
        "category": category,
        "price": price,
      };
}
