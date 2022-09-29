class User {
  final String firstname;
  final String lastname;
  final String email;
  final String contact;
  final String address;
  final String password;

  const User(
      {required this.firstname,
      required this.lastname,
      required this.email,
      required this.contact,
      required this.address,
      required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      contact: json['contact'],
      address: json['address'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "contact": contact,
        "address": address,
        "password": password,
      };
}
