import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'Model/PageViewModel.dart';

void main() {
  runApp(
      const MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<PageViewModel>> products;

  Future<List<PageViewModel>> fetchProducts() async {
    List<PageViewModel> items = [];
    var response = await Dio().get('https://fakestoreapi.com/products/');
    if (response.statusCode == 200) {
      for (var item in response.data) {
        items.add(PageViewModel(item["id"], item["title"], item["price"],
            item["category"], item["description"], item["image"]));
      }
    }
    return items;
  }

  @override
  void initState() {
    super.initState();
    products = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ))
        ],
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Digikala',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      drawer: const Drawer(),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 300,
              color: Colors.amber,
              child: FutureBuilder<List<PageViewModel>>(
                  future: products,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        color: Colors.green,
                      );
                    }
                    return Container(
                      color: Colors.blue,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
