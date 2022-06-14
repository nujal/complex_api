import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

class SignUpSCreen extends StatefulWidget {
  SignUpSCreen({Key? key}) : super(key: key);

  @override
  State<SignUpSCreen> createState() => _SignUpSCreenState();
}

class _SignUpSCreenState extends State<SignUpSCreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordContoller = TextEditingController();

  void login(String email, String password) async {
    try {
      Response response = await post(
        Uri.parse('https://reqres.in/api/register'),
        // Uri.parse('https://reqres.in/api/login'), //login ko lagi

        body: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);
        // print(jsonBody);
        print(jsonBody['token']);
        print('account created successfully');
        // print('login succesfully')    //login ko lagi
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Text('Sign Up Api'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'email',
                contentPadding: EdgeInsets.all(8.0),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: passwordContoller,
              decoration: InputDecoration(
                hintText: 'password',
                contentPadding: EdgeInsets.all(8.0),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // InkWell(
            //   onTap: () {
            //     login(emailController.text.toString(),
            //         passwordContoller.text.toString());
            //   },
            //   child: Container(
            //     height: 50,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(15),
            //       color: Colors.green,
            //     ),
            //     // color: Colors.green[600],
            //     child: Center(
            //       child: Text(
            //         'sign up',
            //         style: TextStyle(fontSize: 18),
            //       ),
            //     ),
            //   ),
            // ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 5.0,
                  fixedSize: Size(150, 40),
                  primary: Colors.purple,
                  padding: EdgeInsets.all(10.0),
                ),
                onPressed: () {
                  login(emailController.text.toString(),
                      passwordContoller.text.toString());
                },
                child: Text(
                  'Sign Up', //Text('login')  //login ko lagi
                  style: TextStyle(fontSize: 15),
                )),
          ],
        ),
      ),
    );
  }
}
