import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cis099_2/routes.dart';
import 'dart:core';

import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  static const titleSize = 80.0;
  static const heading2 = 56.0;
  static const textSize = 16.0;
  static const phoneNumberRegEx = "";
  static bool? rememberMe = false;
  late TextEditingController phoneNumberTextEditingController;
  late TextEditingController passwordTextEditingController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    phoneNumberTextEditingController = TextEditingController();
    passwordTextEditingController = TextEditingController();
  }

  Future<void> readFromStorage() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var phoneNumber = prefs.getString("phoneNumber");
    var password = prefs.getString("password");
    if (phoneNumber != null && password != null){
      phoneNumberTextEditingController.text = phoneNumber;
      passwordTextEditingController.text = password;
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> storeInStorage() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("phoneNumber", phoneNumberTextEditingController.text);
    prefs.setString("password", passwordTextEditingController.text);
    setState(() {
      isLoading = false;
    });
  }
  dynamic createLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.build, color: Colors.red, size: titleSize),
        Text(
          "BILDR",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: titleSize,
          ),
        ),
      ],
    );
  }

  dynamic createTextBox(
    double width,
    double height,
    double textSize,
    TextEditingController textController,
    TextInputType keyBoardType,
    String hintText,
    {
    bool obscureText = false,
  }) {
    return Container(
      alignment: AlignmentGeometry.topRight,
      width: width,
      height: height,
      padding: EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, bottom: 6.0, top: 6.0),
        child: TextField(
          controller: textController,
          keyboardType: keyBoardType,
          textAlign: TextAlign.justify,
          textAlignVertical: TextAlignVertical.top,
          style: TextStyle(fontSize: textSize),
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none
          ),
        ),
      ),
    );
  }

  dynamic createContainer(Size size) {
    var containerWidth = size.width / 1.2;

    return Container(
      height: size.height / 2,
      width: containerWidth,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: heading2,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: createTextBox(
                containerWidth,
                36.0,
                textSize,
                phoneNumberTextEditingController,
                TextInputType.phone,
                "Phone Number"
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: createTextBox(
                containerWidth,
                36.0,
                textSize,
                passwordTextEditingController,
                TextInputType.text,
                "Password",
                obscureText: true,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: rememberMe,
                  activeColor: Colors.red,
                  visualDensity: VisualDensity(horizontal: -4.0),
                  onChanged: (bool? newValue) {
                    setState(() {
                      rememberMe = newValue;
                    });
                  },
                ),
                Text("Remember me", style: TextStyle(fontSize: textSize)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      if (kDebugMode) {
                        print("Forgot password");
                      }
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(fontSize: textSize, color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: isLoading? CircularProgressIndicator() : TextButton(
                onPressed: () {
                  if (passwordTextEditingController.text != ""){
                    storeInStorage();
                  }
                  Navigator.pushNamed(context, AppRoute.dashboard);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(containerWidth, 0.0),
                ),
                child: Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: textSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: textSize),
                  ),
                  TextButton(
                    onPressed: () {
                      if (kDebugMode) {
                        print("SignUP");
                      }
                    },
                    style: TextButton.styleFrom(
                      fixedSize: Size(0.0, 0.0),
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.white,
                      minimumSize: Size(containerWidth, 36.0),
                    ),
                    child: Text(
                      "SignUp",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: textSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [createLogo(), createContainer(size)],
      ),
    );
  }
}
