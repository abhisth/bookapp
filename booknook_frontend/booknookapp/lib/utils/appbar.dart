import 'package:booknook/screen/cart.dart';
import 'package:booknook/screen/profile.dart';
import 'package:booknook/utils/navgator.dart';
import 'package:flutter/material.dart';

AppBar appBar(BuildContext context, title, isAdmin) {
  return AppBar(
    backgroundColor: Colors.blueGrey,
    title: Text(title),
    actions: [
      GestureDetector(
        onTap: () {
          navigateTo(ProfileScreen(), context);
        },
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(Icons.person),
        ),
      ),
      if (isAdmin != true) SizedBox(width: 15),
      if (isAdmin != true)
        GestureDetector(
          onTap: () {
            navigateTo(CartScreen(), context);
          },
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(Icons.shopping_cart),
          ),
        ),
      SizedBox(width: 15)
    ],
  );
}
