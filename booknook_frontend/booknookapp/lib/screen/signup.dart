import 'package:booknook/constant/apiconstant.dart';
import 'package:booknook/model/signupModel.dart';
import 'package:booknook/screen/login.dart';
import 'package:booknook/screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riddhahttp/riddhahttp.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final signupform = GlobalKey<FormState>();

  signup({required User signupformdata}) async {
    String apiUrl = ApiUrl().signupURL;
    var result =
        await RiddhaHttpService().post(apiUrl, signupformdata.toJson());
    if (result['success'] == true) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
    }
  }

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController contactController = TextEditingController();

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
                    key: signupform,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 70),
                          Center(
                            child: Image(
                              image: AssetImage("assets/images/book.jpg"),
                              height: 120.0,
                              width: 120.0,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 30.0),
                            child: Container(
                              child: Text(
                                "Hello!",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily: 'NotoSerif',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.white70),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 30.0),
                            child: Container(
                              child: Text(
                                "Sign up to\nget started",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily: 'NotoSerif',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22.0,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: firstnameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your first name';
                                } else if (RegExp("").hasMatch(value)) {
                                  return null;
                                } else {
                                  return 'Please enter your first name';
                                }
                              },
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.supervised_user_circle,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Please enter your first name',
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
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: Colors.red))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your last name';
                                } else if (RegExp("").hasMatch(value)) {
                                  return null;
                                } else {
                                  return 'Please enter your last name';
                                }
                              },
                              controller: lastnameController,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.supervised_user_circle,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Please enter your last name',
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
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: Colors.red))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your Address';
                                } else if (RegExp("").hasMatch(value)) {
                                  return null;
                                } else {
                                  return 'Please enter your Address';
                                }
                              },
                              controller: addressController,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.location_city,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Please enter your Address',
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
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: Colors.red))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your Contact number';
                                } else if (RegExp("").hasMatch(value)) {
                                  return null;
                                } else {
                                  return 'Please enter your Contact number';
                                }
                              },
                              controller: contactController,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.contact_phone_sharp,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Please enter your Contact number',
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
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: Colors.red))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
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
                              controller: emailController,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Please enter your email',
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
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: Colors.red))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.vpn_key,
                                    color: Colors.white,
                                  ),
                                  suffixIcon: Icon(
                                    Icons.remove_red_eye,
                                  ),
                                  hintText: 'Please enter your password',
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
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: Colors.red))),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Container(
                                height: 50,
                                width: 400,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (signupform.currentState!.validate()) {
                                        User signupformdata = User(
                                            firstname: firstnameController.text,
                                            lastname: lastnameController.text,
                                            email: emailController.text,
                                            contact: contactController.text,
                                            address: addressController.text,
                                            password: passwordController.text);
                                        Fluttertoast.showToast(
                                            msg:
                                                "Redirecting you to login page, please wait..");
                                        signup(signupformdata: signupformdata);
                                      } else {
                                        print("not ok");
                                      }
                                    },
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
                                    child: Center(
                                      child: Text(
                                        "Sign Up",
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
                          Padding(
                              padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
                              child: Row(
                                children: [
                                  Text("Already have an account ? ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'AbrilFatface',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      )),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    },
                                    child: Text(
                                      "Sign in",
                                      style: TextStyle(
                                          color: Colors.white,
                                          decoration: TextDecoration.underline,
                                          fontFamily: 'AbrilFatface',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
