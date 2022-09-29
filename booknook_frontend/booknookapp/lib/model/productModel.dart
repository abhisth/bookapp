class ProductModel {
  ProductModel({
    this.message,
    this.success,
    this.data,
  });

  String? message;
  bool? success;
  List<Datum>? data;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        message: json["message"],
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.author,
    this.description,
    this.category,
    this.price,
    this.image,
  });

  String? id;
  String? name;
  String? author;
  String? description;
  String? category;
  dynamic price;
  String? image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
        author: json["author"],
        description: json["description"],
        category: json["category"],
        price: json["price"] ?? 0,
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "author": author,
        "description": description,
        "category": category,
        "price": price,
        "image": image == null ? null : image,
      };
}
