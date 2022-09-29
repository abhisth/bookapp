import 'package:flutter/material.dart';

navigateTo(screen,context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (BuildContext context) => screen));
}