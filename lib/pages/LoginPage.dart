import 'dart:convert';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_tax_map/pages/MainPage.dart';
// import 'package:easytax/helper/DioService.dart';
// import 'package:easytax/helper/Laoder.dart';
// import 'package:easytax/helper/PermissionHnadle.dart';
// import 'package:easytax/helper/WaitingProcess.dart';
// import 'package:easytax/model/TaxModel.dart';
// import 'package:easytax/pages/HomePage.dart';
// import 'package:easytax/pages/MarkLocationFormPage.dart';
// import 'package:easytax/provider/LocationProvider.dart';
// import 'package:easytax/provider/MainProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../widgets/TileWidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final searchTextController = new TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  void initState() {
    // Location Permission
    // final locationProvider =
    //     Provider.of<LocationProvider>(context, listen: false);
    // PermissionService.requestPermission().whenComplete(() {
    //   locationProvider.getCurentLocation();
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final mainProvider = Provider.of<MainProvider>(context);

    return Scaffold(
        // appBar: AppBar(title: Text("Login")),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Dashboard WEB",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  "assets/images/taxlogo.png",
                  width: 200,
                ),
                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  width: MediaQuery.of(context).size.width /3,
                  child: TextField(
                    controller: _username,
                    decoration: InputDecoration(
                      
                      // focusColor: primary,
                      // fillColor: fillColor,
                      filled: true,
                      prefixIcon: Icon(Icons.mail),
                      hintText: "Username",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      // labelText: 'Username',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width /3,
                  child: TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                      // focusColor: primary,
                      // fillColor: fillColor,
                      filled: true,
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width /3,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))),
                      ),
                    ),
                    onPressed: () async {
                      var user = _username.text.toLowerCase();
                      var pass = _password.text.toLowerCase();
                      if ((user == "admin1" && pass == "admin") ||
                          (user == "admin2" && pass == "admin") ||
                          (user == "admin3" && pass == "admin") ||
                          (user == "admin4" && pass == "admin") ||
                          (user == "admin5" && pass == "admin") ||
                          (user == "admin6" && pass == "admin") ||
                          (user == "admin7" && pass == "admin") ||
                          (user == "admin8" && pass == "admin") ||
                          (user == "admin9" && pass == "admin") ||
                          (user == "admin10" && pass == "admin")) {
                        // Navigator.pushNamed(context, "/home");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MainPage()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Username or Password not found")),
                        );
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Text(
                        'login',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
