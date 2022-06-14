import 'dart:convert';

import 'package:api_practice/model/api_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class PostsScreen extends StatefulWidget {
  PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => PostsScreenState();
}

class PostsScreenState extends State<PostsScreen> {
  String postUrl = "https://jsonplaceholder.typicode.com/posts";
  List<PostsModel> postList = [];
  Future<List<PostsModel>> getData() async {
    final Response response = await http.get(Uri.parse(postUrl));
    // var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      postList.clear();
      // var body = response.body;
      var jsonBody = jsonDecode(response.body);
      jsonBody.forEach((e) {
        postList.add(PostsModel.fromJson(e));
      });
      return postList;
    }
    return postList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Text('Posts Api'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        itemCount: postList.length,
                        itemBuilder: (context, i) {
                          return Card(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Title',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(postList[i].title.toString()),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Description',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(postList[i].body.toString()),
                              ],
                            ),
                          ));
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}
