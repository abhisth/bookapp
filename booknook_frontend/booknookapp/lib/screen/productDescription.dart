// ignore_for_file: must_be_immutable

import 'package:booknook/constant/apiconstant.dart';
import 'package:booknook/main.dart';
import 'package:booknook/model/productModel.dart';
import 'package:booknook/screen/addBook.dart';
import 'package:booknook/screen/HomePage.dart';
import 'package:booknook/utils/appbar.dart';
import 'package:booknook/utils/headers.dart';
import 'package:booknook/utils/navgator.dart';
import 'package:booknook/utils/toast.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riddhahttp/riddhahttp.dart';
import 'package:shake/shake.dart';

class ProductDescriptionScreen extends StatefulWidget {
  ProductDescriptionScreen({Key? key, required this.id}) : super(key: key);
  String id;

  @override
  _ProductDescriptionScreenState createState() =>
      _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState extends State<ProductDescriptionScreen> {
  bool isAdmin = false;
  bool loading = false;
  Datum? product;
  XFile? photo;

  getProduct() async {
    setState(() {
      loading = true;
    });
    String url = ApiUrl().getProductURL + '/view/${widget.id}';
    var result = await RiddhaHttpService().get(url);
    if (result['success'] == true) {
      setState(() {
        loading = false;
        product = Datum.fromJson(result['data']);
      });
    } else {
      setState(() {
        loading = false;
      });
      snackBar(context, result['message']);
    }
  }

  checkisAdmin() async {
    bool data = await getIsAdmin();
    setState(() {
      isAdmin = data;
    });
  }

  addProductImage(id) async {
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(photo!.path, filename: photo!.name),
    });
    var result =
        await Dio().put(ApiUrl().uploadProductPhoto + id, data: formData);
    if (result.data['success'] == true) {
      snackBar(context, result.data['message']);
    } else {
      snackBar(context, result.data['message']);
    }
  }

  addOrRemoveCartItem(id) async {
    String url = ApiUrl().addRemoveCartItem;
    String token = await getToken();
    var result = await Dio().put(url + id, options: await headerOptions(token));
    if (result.statusCode == 200) {
      if (result.data['success'] == true) {
        snackBar(context, result.data['message']);
      } else {
        snackBar(context, result.data['message']);
      }
    }
  }

  deleteAdminProduct(id) async {
    String url = ApiUrl().deleteProduct;
    String token = await getToken();
    var result =
        await Dio().delete(url + id, options: await headerOptions(token));
    if (result.statusCode == 200) {
      print(result);
      if (result.data['success'] == true) {
        snackBar(context, result.data['message']);
        navigateTo(LandingScreen(), context);
      } else {
        snackBar(context, result.data['message']);
      }
    }
  }

  @override
  void initState() {
    checkisAdmin();
    getProduct();
    ShakeDetector.autoStart(onPhoneShake: () {
      navigateTo(LandingScreen(), context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = product?.image != null
        ? product!.image!
            .replaceAll(' ', '%20')
            .replaceAll('http://localhost:80', ApiUrl().baseApi)
        : 'https://kiranametro.com/admin/public/size_primary_images/no-image.jpg';
    return Scaffold(
      appBar: appBar(context, product?.name ?? '', isAdmin),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                onPressed: () {
                  isAdmin != true
                      ? addOrRemoveCartItem(product?.id)
                      : navigateTo(
                          AddProductScreen(edit: true, toEditData: product),
                          context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(isAdmin != true ? Icons.shopping_cart : Icons.edit),
                    SizedBox(width: 15),
                    if (isAdmin != true) Text('Add to Cart') else Text('Edit')
                  ],
                )),
            if (isAdmin == true)
              ElevatedButton(
                  onPressed: () {
                    deleteAdminProduct(product?.id);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 15),
                      Text('Delete')
                    ],
                  )),
            if (isAdmin == true)
              IconButton(
                  onPressed: () async {
                    var image = await ImagePicker.platform.getImage(
                        source: ImageSource.gallery, imageQuality: 50);
                    if (image != null) {
                      setState(() {
                        photo = image;
                      });
                      await addProductImage(widget.id);
                      await getProduct();
                    }
                  },
                  icon: Icon(Icons.camera_alt_outlined)),
          ],
        ),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Image.network(imageUrl),
                  SizedBox(height: 10),
                  Text(
                    product?.name ?? '',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal),
                  ),
                  Text(
                    "by " + '${product?.author}',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(product?.description ?? ''),
                  SizedBox(height: 10),
                  // Text(product?.category ?? ''),
                  // SizedBox(height: 10),
                  Text(
                    "Price : Nrs. " + '${product?.price}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
    );
  }
}
