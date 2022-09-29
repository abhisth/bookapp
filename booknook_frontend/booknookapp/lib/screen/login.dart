import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:booknook/constant/apiconstant.dart';
import 'package:booknook/model/loginModel.dart';
import 'package:booknook/screen/HomePage.dart';
import 'package:booknook/screen/signup.dart';
import 'package:booknook/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:riddhahttp/riddhahttp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

void notify(
    {String channelKey = "key1",
    required String heading,
    required String notificationMessage}) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 1,
        channelKey: channelKey,
        title: heading,
        body: notificationMessage,
        notificationLayout: NotificationLayout.BigPicture,
        bigPicture:
            'https://previews.123rf.com/images/houbacze/houbacze1709/houbacze170900829/86901846-vector-illustration-background-welcome-back.jpg'),
  );
}

class _LoginScreenState extends State<LoginScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final loginform = GlobalKey<FormState>();
  String userType = 'User';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  userLogin() async {
    String userLoginUrl =
        userType == 'User' ? ApiUrl().userLoginURL : ApiUrl().adminLoginURL;
    var result = await RiddhaHttpService().post(
        userLoginUrl,
        LoginModel(
                email: emailController.text, password: passwordController.text)
            .toJson());
    var response = LoginResponseModel.fromJson(result);
    if (response.success == true) {
      SharedPreferences prefs = await _prefs;
      prefs.setString('session', jsonEncode(response.data));
      prefs.setString('token', response.accessToken!);
      prefs.setBool('isAdmin', response.isAdmin!);
      await Vibration.vibrate(duration: 200);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LandingScreen()),
          (Route<dynamic> route) => false);
      notify(
          heading:
              'Welcome Back ${response.data!.firstname} ${response.data!.lastname}',
          notificationMessage:
              "Logged in as ${response.data!.firstname} ${response.data!.lastname}");
    } else {
      snackBar(context, response.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    child: SvgPicture.asset(
                      'assets/images/top.svg',
                      width: 200,
                      height: 150,
                    )),
                Container(
                  alignment: Alignment.center,
                  child: Form(
                    key: loginform,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 100),
                        Center(
                          child: Image(
                            image: AssetImage("assets/images/book.jpg"),
                            height: 120.0,
                            width: 120.0,
                          ),
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 30.0),
                          child: Text(
                            "Hello Again!",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'NotoSerif',
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                                color: Colors.white70),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 30.0),
                          child: Text(
                            "Welcome\nback",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'NotoSerif',
                                fontWeight: FontWeight.w700,
                                fontSize: 24.0),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              } else if (RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                                return null;
                              } else {
                                return 'Enter valid email';
                              }
                            },
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            controller: emailController,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                hintText: ' Please enter your email',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(color: Colors.red))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            validator: RequiredValidator(
                                errorText: " Please enter your password"),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            obscureText: true,
                            controller: passwordController,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                hintText: 'Please enter your password',
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(color: Colors.red))),
                          ),
                        ),
                        SizedBox(
                          height: 0,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("I am an ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              DropdownButton<String>(
                                value: userType,
                                items: <String>['User', 'Admin'].map((
                                  String value,
                                ) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          color: Colors.black,
                                          backgroundColor: Colors.white70),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (_) {
                                  setState(() {
                                    userType = _!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: Container(
                                height: 50,
                                width: 300,
                                child: Center(
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Colors.white70,
                                          ),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0)))),
                                      onPressed: () async {
                                        if (loginform.currentState!
                                            .validate()) {
                                          // snackBar(context,
                                          //     "Logging in, please wait");
                                          Fluttertoast.showToast(
                                              msg: "Logging in, please wait..");
                                          await userLogin();
                                        }
                                      },
                                      child: Center(
                                        child: Text(
                                          "Log In",
                                          style: TextStyle(
                                              color: Colors.deepPurple,
                                              fontSize: 20,
                                              fontFamily: 'AbrilFatface',
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account ? ",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'AbrilFatface',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                SignupScreen()));
                                  },
                                  child: Text(
                                    " Sign up",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'AbrilFatface',
                                        fontWeight: FontWeight.w700,
                                        decoration: TextDecoration.underline,
                                        fontSize: 16),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
