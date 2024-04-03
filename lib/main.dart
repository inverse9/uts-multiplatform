import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Map<String, String>> data = [
    {"desc": "ahsdbjhasdbnsand", "img": "https://picsum.photos/id/1"},
    {"desc": "ahsdbjhasdbnsand2", "img": "https://picsum.photos/id/2"},
    {"desc": "ahsdbjhasdbnsand3", "img": "https://picsum.photos/id/3"},
  ];
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Navigator(
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) => Grid(data: data),
            );
          },
        ),
      ),
    );
  }
}

class Grid extends StatelessWidget {
  final List<Map<String, String>> data;
  const Grid({Key? key, required List<Map<String, String>> this.data});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      itemCount: 3,
      itemBuilder: (_, i) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  data: data[i],
                ),
              ),
            );
          },
          child: Stack(children: [
            Image.network(
              data[i]["img"]! + "/200/200",
            ),
            Positioned(
                child: WishlistButton(
              isWished: false,
              onTap: () {
                print('yes');
              },
            ))
          ]),
        );
      },
    );
  }
}

class DetailPage extends StatelessWidget {
  final Map<String, String> data;

  const DetailPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('detail'),
      ),
      body: Column(
        children: [
          Image.network(data["img"]! + "/500/500"),
          Text(data["desc"]!),
        ],
      ),
    );
  }
}

class WishlistButton extends StatelessWidget {
  final bool isWished;
  final VoidCallback onTap;

  const WishlistButton({Key? key, required this.isWished, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isWished ? Icons.favorite : Icons.favorite_border,
        color: isWished ? Colors.red : Colors.grey,
      ),
    );
  }
}
