import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WishlistNotifier(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: GridPage(),
      ),
    );
  }
}

class GridPage extends StatelessWidget {
  final List<Map<String, String>> data = [
    {"desc": "ahsdbjhasdbnsand", "img": "https://picsum.photos/id/0/200/200"},
    {"desc": "ahsdbjhasdbnsand2", "img": "https://picsum.photos/id/1/200/200"},
    {"desc": "ahsdbjhasdbnsand3", "img": "https://picsum.photos/id/2/200/200"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    data: data[index],
                    index: index,
                  ),
                ),
              );
            },
            child: Image.network(
              data[index]["img"]!,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Map<String, String> data;
  final int index;

  DetailPage({required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Column(
        children: [
          Image.network(
            data["img"]!,
            fit: BoxFit.cover,
          ),
          Text(data["desc"]!),
          Consumer<WishlistNotifier>(
            builder: (context, wishlist, _) => IconButton(
              icon: Icon(
                wishlist.wishlist.contains(index)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: wishlist.wishlist.contains(index)
                    ? Colors.red
                    : Colors.grey,
              ),
              onPressed: () {
                wishlist.toggleWishlist(index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WishlistNotifier extends ChangeNotifier {
  Set<int> _wishlist = {};

  Set<int> get wishlist => _wishlist;

  void toggleWishlist(int index) {
    if (_wishlist.contains(index)) {
      _wishlist.remove(index);
    } else {
      _wishlist.add(index);
    }
    notifyListeners();
  }
}
