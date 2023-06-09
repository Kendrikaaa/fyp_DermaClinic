// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:developer';

import 'package:dermaclinic_patients_fyp_20048674/routes/home.dart';
import 'package:dermaclinic_patients_fyp_20048674/routes/signup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image(
                      image: AssetImage('images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Center(
                  child: Text(
                    "Welcome to Derma clinic \n                 Login",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Email",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          final regex = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                          if (!regex.hasMatch(value)) {
                            return 'This field must be an email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Text(
                        "Password",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: isPasswordVisible ? false : true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            child: Icon(
                              Icons.remove_red_eye,
                              size: 16,
                              color: Color(0xff8696BB),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      InkWell(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            final bool loginStatus = (await Services.login(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim()));
                            log(loginStatus.toString());
                            if (!loginStatus) {
                              //login unsuccesful
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Incorrect credentials. Try again')),
                              );
                              return;
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login successful')),
                            );
                            var shared = await SharedPreferences.getInstance();

                            shared.setString(
                                "email", emailController.text.trim());
                            log(emailController.text.trim());
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return HomePage();
                              },
                            ));
                          }
                        },
                        child: Container(
                          height: 65,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Color(0xff4894FE),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: Center(
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New User? ",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    InkWell(
                      onTap: () {
                        Services.createTable().then((result) {
                          if (result.contains("success")) {
                            // Table is created successfully.
                            log("Created a table");
                          } else {
                            log(result.toString());
                          }
                        });
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return SignUpPage();
                          },
                        ));
                      },
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff4894FE),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
