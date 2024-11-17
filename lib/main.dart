import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';
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
      body: Column(
        children: [
          Container(
            height: 420,
            child: FutureBuilder<List<PageViewModel>>(
                future: products,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<PageViewModel>? items = snapshot.data;
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        PageView.builder(
                            itemCount: items!.length,
                            itemBuilder: (context, position) {
                              return productItem(items[position]);
                            })
                      ],
                    );
                  }
                  return JumpingDots(
                    color: Colors.black,
                    animationDuration: const Duration(milliseconds: 200),
                  );
                }),
          )
        ],
      ),
    );
  }

  Padding productItem(PageViewModel item) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Image.network(
            item.image,
            width: 120,
          ),
          Text(
            item.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            item.description,
            textAlign: TextAlign.center,
          ),
          Text(
            item.price.toString(),
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 16, 120, 120)),
          )
        ],
      ),
    );
  }
}
