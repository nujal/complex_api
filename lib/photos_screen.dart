import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PhotoScreen extends StatefulWidget {
  PhotoScreen({Key? key}) : super(key: key);
  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  String photoUrl = "https://jsonplaceholder.typicode.com/photos";
  List<Photos> photoList = [];
  Future<List<Photos>> getPhoto() async {
    final Response response = await http.get(Uri.parse(photoUrl));
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      photoList.clear();
      var jsonBody = jsonDecode(response.body);

      jsonBody.forEach((element) {
        Photos photos = Photos(
            title: element['title'], url: element['url'], id: element['id']);
        photoList.add(photos);
      });
      return photoList;
    }
    return photoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Text('Photo API'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getPhoto(),
          builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
            //snapshot matra lekhe tala ko code garne
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  itemCount: photoList.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            // NetworkImage(photoList[i].url.toString()),

                            NetworkImage(snapshot.data![i].url.toString()),
                      ),
                      title: Text('ID' + snapshot.data![i].id.toString()),
                      subtitle: Text(snapshot.data![i].title.toString()),
                    );
                  });
            }
          }),
    );
  }
}

class Photos {
  String title, url;
  int id;
  Photos({required this.title, required this.url, required this.id});
}
