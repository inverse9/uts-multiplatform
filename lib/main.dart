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
        home: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.indigo,
        selectedIndex: currentPageIndex,
        destinations: [
          NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: "home"),
          NavigationDestination(icon: Icon(Icons.favorite), label: "wishlist"),
        ],
      ),
      body: [GridPage(), WishlistPage()][currentPageIndex],
    );
  }
}

class GridPage extends StatelessWidget {
  final List<Map<String, String>> data = [
    {
      "id": "1",
      "desc": "ahsdbjhasdbnsand",
      "img": "https://picsum.photos/id/0/200/200"
    },
    {
      "id": "2",
      "desc": "ahsdbjhasdbnsand2",
      "img": "https://picsum.photos/id/1/200/200"
    },
    {
      "id": "3",
      "desc": "ahsdbjhasdbnsand3",
      "img": "https://picsum.photos/id/2/200/200"
    },
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
            builder: (context, notifier, _) => IconButton(
              icon: Icon(
                notifier.wishlist.any((item) => item["id"] == data["id"])
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: notifier.wishlist.any((item) => item["id"] == data["id"])
                    ? Colors.red
                    : Colors.grey,
              ),
              onPressed: () {
                notifier.toggleWishlist(data);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WishlistNotifier extends ChangeNotifier {
  Set<Map<String, String>> _wishlist = {};

  Set<Map<String, String>> get wishlist => _wishlist;

  void toggleWishlist(Map<String, String> data) {
    var id = data["id"];
    if (_wishlist.any((item) => item["id"] == id)) {
      _wishlist.removeWhere((item) => item["id"] == id);
    } else {
      _wishlist.add(data);
      print(_wishlist);
    }
    notifyListeners();
  }
}

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<WishlistNotifier>();
    if (appState._wishlist.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Adjust the cross axis count as needed
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: appState._wishlist.length,
      itemBuilder: (context, index) {
        var pair = appState._wishlist.toList()[index];
        return Column(
          children: [
            Image.network(
              pair["img"]!,
              fit: BoxFit.cover,
            ),
            Text(pair["desc"]!),
          ],
        );
      },
    );
  }
}
