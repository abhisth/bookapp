import 'package:flutter/material.dart';

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
snackBar(context, msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg),
  ));
}
