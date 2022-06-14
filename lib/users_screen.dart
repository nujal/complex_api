import 'package:api_practice/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'dart:convert';

class UsersScreen extends StatefulWidget {
  UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  String userUrl = "https://jsonplaceholder.typicode.com/users";
  List<UsersModel> userList = [];

  Future<List<UsersModel>> getUser() async {
    final Response response = await http.get(Uri.parse(userUrl));

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      userList.clear();
      var userBody = jsonDecode(response.body);
      userBody.forEach((e) {
        userList.add(UsersModel.fromJson(e));
      });
      return userList;
    }
    return userList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Text('User api'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getUser(),
        builder: (context, AsyncSnapshot<List<UsersModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ReusableRow(
                              title: 'name',
                              value: snapshot.data![i].name.toString()),
                          ReusableRow(
                              title: 'Username',
                              value: snapshot.data![i].username.toString()),
                          ReusableRow(
                              title: 'Email',
                              value: snapshot.data![i].email.toString()),
                          ReusableRow(
                              title: 'Address',
                              value:
                                  snapshot.data![i].address!.city.toString()),
                          ReusableRow(
                              title: 'Latitude',
                              value: snapshot.data![i].address!.geo!.lat
                                  .toString()),
                        ],
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}
