import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:booknook/model/loginModel.dart';
import 'package:booknook/screen/HomePage.dart';
import 'package:booknook/screen/login.dart';
import 'package:booknook/screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(null, // icon for your app notification
      [
        NotificationChannel(
            channelKey: 'key1',
            channelName: 'Proto Coders Point',
            channelDescription: "Notification example",
            defaultColor: const Color(0XFF9050DD),
            ledColor: Colors.white,
            playSound: true,
            enableLights: true,
            importance: NotificationImportance.High,
            enableVibration: true)
      ]);
  
  runApp(BookApp());
}



class BookApp extends StatefulWidget {
  const BookApp({Key? key}) : super(key: key);

  @override
  State<BookApp> createState() => _BookAppState();
}

Future<Data> getSessionData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? session = prefs.getString('session');
  if (session != null) {
    Data sessiondata = Data.fromJson(jsonDecode(session));
    return sessiondata;
  } else {
    return Data();
  }
}

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  return token ?? '';
}

Future<bool> getIsAdmin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isAdmin = prefs.getBool('isAdmin');
  return isAdmin ?? false;
}

class _BookAppState extends State<BookApp> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isLoggedin = false;

  checkSession() async {
    SharedPreferences prefs = await _prefs;
    Data? session = await getSessionData();
    String token = await getToken();
    if (session.id != null && token != null) {
      setState(() {
        isLoggedin = true;
      });
    }
  }

  @override
  void initState() {
    checkSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Book-Nook App",
      home: isLoggedin ? LandingScreen() : WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  child: SvgPicture.asset(
                    'assets/images/splash.svg',
                    width: 90,
                    height: 500,
                  )),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // decoration: BoxDecoration(image: DecorationImage(image: AssetImage(''))),
                      child: Center(
                        child: Image.asset(
                          "assets/images/book.jpg",
                          height: 120.0,
                          width: 120.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "The Book-Nook",
                            style: TextStyle(
                                fontFamily: 'NotoSerif',
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                                fontSize: 40.0,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Eat - ",
                                style: TextStyle(
                                    color: Colors.white60,
                                    fontFamily: 'BebasNeue',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20.0),
                              ),
                              Text(
                                "Read",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'BebasNeue',
                                    fontWeight: FontWeight.bold,
                                    // decoration: TextDecoration.underline,
                                    fontSize: 28.0),
                              ),
                              Text(
                                " - Sleep - Repeat ",
                                style: TextStyle(
                                    color: Colors.white60,
                                    fontFamily: 'BebasNeue',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 140.0),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 160,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(),
                                    ));
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.white70,
                                  ),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0)))),
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontFamily: 'NotoSerif',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40.0,
                          ),
                          Container(
                            width: 160,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignupScreen(),
                                    ));
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.white70,
                                  ),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0)))),
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontFamily: 'NotoSerif',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
