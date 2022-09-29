class ProfileModel {
    ProfileModel({
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

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
    };
}
