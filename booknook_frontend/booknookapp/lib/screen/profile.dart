import 'package:booknook/constant/apiconstant.dart';
import 'package:booknook/main.dart';
import 'package:booknook/model/profileModel.dart';
import 'package:booknook/screen/addBook.dart';
import 'package:booknook/screen/login.dart';
import 'package:booknook/utils/headers.dart';
import 'package:booknook/utils/navgator.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileModel profileData = ProfileModel();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool loading = false;
  bool isAdmin = false;

  checkisAdmin() async {
    bool data = await getIsAdmin();
    setState(() {
      isAdmin = data;
    });
  }

  getUserDetail() async {
    setState(() {
      loading = true;
    });
    String url = ApiUrl().getUserURL;
    String token = await getToken();
    var result = await Dio().get(url, options: await headerOptions(token));
    if (result.statusCode == 200) {
      if (result.data['success'] == true) {
        setState(() {
          loading = false;
          profileData = ProfileModel.fromJson(result.data['data']);
        });
      } else {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    getUserDetail();
    checkisAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            onPressed: () async {
              SharedPreferences prefs = await _prefs;
              prefs.remove('session');
              prefs.remove('token');
              prefs.remove('isAdmin');
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout),
                SizedBox(width: 15),
                Text('Logout')
              ],
            )),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: profileData.id != null
            ? Text(profileData.firstname!.toUpperCase() +
                ' ' +
                profileData.lastname!.toUpperCase())
            : Text(''),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  CircleAvatar(
                      radius: 55,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100)),
                          child: Image.network(profileData.profile!))),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      Text(
                        "Name: " +
                            profileData.firstname!.toUpperCase() +
                            ' ' +
                            profileData.lastname!.toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Address: " + profileData.address!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Contact number: " + profileData.contact!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Email address: " + profileData.email!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  // Text(profileData.userType!),
                  if (isAdmin == true)
                    ElevatedButton(
                        onPressed: () {
                          navigateTo(AddProductScreen(), context);
                        },
                        child: Text('Add Product'),
                        style:
                            ElevatedButton.styleFrom(primary: Colors.blueGrey))
                ],
              ),
            ),
    );
  }
}
