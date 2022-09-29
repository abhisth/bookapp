class LoginModel {
  final String email;
  final String password;

  const LoginModel({required this.email, required this.password});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}

class LoginResponseModel {
  LoginResponseModel({
    this.message,
    this.accessToken,
    this.isAdmin,
    this.data,
    this.success,
  });

  String? message;
  String? accessToken;
  bool? isAdmin;
  Data? data;
  bool? success;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        message: json["message"],
        accessToken: json["accessToken"],
        isAdmin: json["isAdmin"],
        data: Data.fromJson(json["data"]),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "accessToken": accessToken,
        "isAdmin": isAdmin,
        "data": data!.toJson(),
        "success": success,
      };
}

class Data {
  Data({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.password,
    this.contact,
    this.address,
    this.userType,
    this.profile,
    this.cart,
    this.v,
  });

  String? id;
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  String? contact;
  String? address;
  String? userType;
  String? profile;
  List<dynamic>? cart;
  int? v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        password: json["password"],
        contact: json["contact"],
        address: json["address"],
        userType: json["userType"],
        profile: json["profile"],
        cart: List<dynamic>.from(json["cart"].map((x) => x)),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "password": password,
        "contact": contact,
        "address": address,
        "userType": userType,
        "profile": profile,
        "cart": List<dynamic>.from(cart!.map((x) => x)),
        "__v": v,
      };
}

// class SessionProvider {
//   static Data? session;
//   static String? token;
//   static bool? isAdmin;

//   static setSession(data, tok,admin) {
//     session = data;
//     token = tok;
//     isAdmin = admin;
//   }
// }
