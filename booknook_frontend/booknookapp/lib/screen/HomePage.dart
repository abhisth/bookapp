import 'package:booknook/constant/apiconstant.dart';
import 'package:booknook/main.dart';
import 'package:booknook/model/productModel.dart';
import 'package:booknook/screen/productDescription.dart';
import 'package:booknook/utils/appbar.dart';
import 'package:booknook/utils/navgator.dart';
import 'package:flutter/material.dart';
import 'package:riddhahttp/riddhahttp.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool loading = false;
  bool isAdmin = false;
  ProductModel products = ProductModel();

  Future<void> getProducts() async {
    setState(() {
      loading = true;
    });
    String getProductUrl = ApiUrl().getProductURL;
    var result = await RiddhaHttpService().get(getProductUrl);
    var response = ProductModel.fromJson(result);
    if (response.success == true) {
      setState(() {
        loading = false;
        products = response;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  checkisAdmin() async {
    bool data = await getIsAdmin();
    setState(() {
      isAdmin = data;
    });
  }

  @override
  void initState() {
    getProducts();
    checkisAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, isAdmin != true ? 'Home' : 'Admin Home', isAdmin),
      body: products.data == null
          ? Center(
              child: Text('No Products'),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text('Total Books Available : '),
                      Spacer(),
                      Text(products.data!.length.toString()),
                    ],
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: getProducts,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          Datum data = products.data![index];
                          String imageUrl = data.image != null
                              ? data.image!.replaceAll(' ', '%20').replaceAll(
                                  'http://localhost:80', ApiUrl().baseApi)
                              : 'https://kiranametro.com/admin/public/size_primary_images/no-image.jpg';
                          return GestureDetector(
                            onTap: () {
                              navigateTo(ProductDescriptionScreen(id: data.id!),
                                  context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Card(
                                color: Colors.blueGrey,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        imageUrl,
                                        height: 120,
                                        width: 85,
                                      ),
                                      SizedBox(
                                        height: 15,
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            data.name ?? '',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 18.0),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "by " + data.author.toString() ??
                                                '',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 12.0),
                                          ),
                                          SizedBox(height: 65),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 0),
                                                child: Container(
                                                  width: 60,
                                                  child: Text(
                                                    data.category ?? '',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        80, 0, 0, 0),
                                                child: Container(
                                                  width: 60,
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Text(
                                                    "Nrs. " +
                                                        data.price.toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: products.data?.length),
                  ),
                ),
              ],
            ),
    );
  }
}
