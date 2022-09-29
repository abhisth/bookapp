// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:booknook/constant/apiconstant.dart';
import 'package:booknook/main.dart';
import 'package:booknook/model/addBookModel.dart';
import 'package:booknook/model/productModel.dart';
import 'package:booknook/screen/HomePage.dart';
import 'package:booknook/utils/appbar.dart';
import 'package:booknook/utils/navgator.dart';
import 'package:booknook/utils/toast.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:riddhahttp/riddhahttp.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({Key? key, this.edit, this.toEditData}) : super(key: key);
  bool? edit;
  Datum? toEditData;
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  XFile? photo;
  bool isAdmin = false;
  checkisAdmin() async {
    bool data = await getIsAdmin();
    setState(() {
      isAdmin = data;
    });
  }

  editProduct(id) async {
    String url = ApiUrl().updateProduct + id;
    var result = await RiddhaHttpService().put(
        url,
        AddProductModel(
                name: name.text,
                author: author.text,
                category: category.text,
                description: description.text,
                price: price.text)
            .toJson());
    if (result['success'] == true) {
      name.clear();
      author.clear();
      description.clear();
      category.clear();
      price.clear();
      navigateTo(LandingScreen(), context);
    } else {
      snackBar(context, result['message']);
    }
  }

  addProduct() async {
    String url = ApiUrl().addProduct;
    var result = await RiddhaHttpService().post(
        url,
        AddProductModel(
                name: name.text,
                author: author.text,
                category: category.text,
                description: description.text,
                price: price.text)
            .toJson());
    if (result['success'] == true) {
      name.clear();
      author.clear();
      description.clear();
      category.clear();
      price.clear();
      snackBar(context, result['message']);
    } else {
      snackBar(context, result['message']);
    }
  }

  @override
  void initState() {
    checkisAdmin();
    if (widget.edit == true) {
      name.text = widget.toEditData!.name!;
      author.text = widget.toEditData!.author!;
      description.text = widget.toEditData!.description!;
      category.text = widget.toEditData!.category!;
      price.text = widget.toEditData!.price.toString();
    }
    super.initState();
  }

  final name = TextEditingController();
  final author = TextEditingController();
  final description = TextEditingController();
  final category = TextEditingController();
  final price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Add Book', isAdmin),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Book Name',
                labelStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    fontFamily: 'AvenirLight'),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
                enabledBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0)),
              ),
              controller: name,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Book Author',
                labelStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    fontFamily: 'AvenirLight'),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
                enabledBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0)),
              ),
              controller: author,
            ),
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                labelText: "Book Description",
                labelStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    fontFamily: 'AvenirLight'),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
                enabledBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0)),
              ),
              controller: description,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Book Category",
                labelStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    fontFamily: 'AvenirLight'),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
                enabledBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0)),
              ),
              controller: category,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Book Price',
                labelStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    fontFamily: 'AvenirLight'),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
                enabledBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0)),
              ),
              controller: price,
            ),
            TextButton(
                onPressed: () {
                  widget.edit == true
                      ? editProduct(widget.toEditData!.id)
                      : addProduct();
                },
                child: Text(widget.edit == true ? 'Edit Book' : 'Add Book'))
          ],
        ),
      ),
    );
  }
}
