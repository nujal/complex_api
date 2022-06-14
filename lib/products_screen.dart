import 'package:api_practice/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

class ProductsScreen extends StatefulWidget {
  ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String productUrl =
      "https://webhook.site/eea636b8-9e00-4f13-8303-6be2a730c383";
  // List<ProductsModel> productsList = [];
  // ProductsModel productsModel;

  Future<ProductsModel?> getProducts() async {
    print("Inside get products");
    try {
      final Response response = await get(Uri.parse(productUrl));

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        // var productBody = jsonDecode(response.body);
        // List<Data> resData = productBody['data'];

        // productsList
        //     .addAll(resData.map((e) => ProductsModel.fromJson(e)).toList());
        return ProductsModel.fromJson(jsonDecode(response.body));
      } else {
        print("No data");
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          title: Text('Products Api'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getProducts(),
          builder: (context, AsyncSnapshot<ProductsModel?> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  itemCount:
                      snapshot.data!.data![0].products![0].images!.length,
                  itemBuilder: (context, i) {
                    // print(snapshot.data!.data![0].products![0].images![i].url!);
                    return Image.network(
                      //   snapshot.data![i].data![i].products![i].images![i].url
                      //       .toString(),
                      // snapshot.data[0].
                      snapshot.data!.data![0].products![0].images![i].url!,
                      height: 100,
                      width: 100,
                    );
                  });
            }
          },
        ));
  }
}
