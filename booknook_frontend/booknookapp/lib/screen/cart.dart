import 'package:booknook/constant/apiconstant.dart';
import 'package:booknook/main.dart';
import 'package:booknook/model/cartModel.dart';
import 'package:booknook/utils/appbar.dart';
import 'package:booknook/utils/headers.dart';
import 'package:booknook/utils/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool loading = false;
  bool isAdmin = false;
  bool removeLoading = false;
  List<CartModel> cartItems = [];

  getCartItems() async {
    setState(() {
      loading = true;
      cartItems = [];
    });
    String url = ApiUrl().getUserCartURL;
    String token = await getToken();

    var result = await Dio().get(url, options: await headerOptions(token));
    if (result.statusCode == 200) {
      if (result.data['success'] == true) {
        setState(() {
          loading = false;
          for (var item in result.data['data']) {
            cartItems.add(CartModel.fromJson(item));
          }
        });
      } else {
        setState(() {
          cartItems = [];
          loading = false;
        });
      }
    }
  }

  addOrRemoveCartItem(id) async {
    String url = ApiUrl().addRemoveCartItem;
    String token = await getToken();

    var result = await Dio().put(url + id, options: await headerOptions(token));
    if (result.statusCode == 200) {
      if (result.data['success'] == true) {
        await getCartItems();
      }
    }
  }

  checkoutCartItems() async {
    String url = ApiUrl().checkoutOrder;
    String token = await getToken();

    var result = await Dio().put(url,
        data: {'cart': cartItems}, options: await headerOptions(token));
    if (result.statusCode == 200) {
      if (result.data["success"] == true) {
        await getCartItems();
        snackBar(context, result.data['message']);
      }
    }
  }

  @override
  void initState() {
    getCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Cart', isAdmin),
      bottomNavigationBar: cartItems.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    await checkoutCartItems();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.done),
                      SizedBox(width: 15),
                      Text('Checkout', )
                    ],
                  )),
            )
          : null,
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (cartItems.isEmpty
              ? Center(child: Text('No Cart Items'))
              : ListView.builder(
                  itemBuilder: (ctx, index) {
                    CartModel item = cartItems[index];
                    String imageUrl = item.image!
                        .replaceAll(' ', '%20')
                        .replaceAll('http://localhost:80', ApiUrl().baseApi);

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(item.name!),
                        leading: Image.network(imageUrl),
                        subtitle: Text("by " +
                            item.author! +
                            '\n' +
                            "Nrs. " +
                            item.price.toString()),
                        trailing: IconButton(
                            onPressed: () {
                              addOrRemoveCartItem(item.id);
                            },
                            icon: Icon(Icons.delete)),
                      ),
                    );
                  },
                  itemCount: cartItems.length,
                  
                )),
    );
  }
}
