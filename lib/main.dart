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
          useMaterial3: true,
          colorSchemeSeed: Colors.brown,
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
        indicatorColor: Theme.of(context).colorScheme.primary,
        selectedIndex: currentPageIndex,
        destinations: [
          NavigationDestination(
              selectedIcon: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              icon: Icon(Icons.home_outlined),
              label: "Home"),
          NavigationDestination(
              selectedIcon: Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              icon: Icon(Icons.favorite_border),
              label: "Wishlist"),
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
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Product',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
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
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Detail',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
      ),
      body: ListView(
        children: [
          Image.network(
            data["img"]!,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Kipas angin portable full dingin",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize:
                          Theme.of(context).textTheme.titleLarge?.fontSize,
                      fontWeight: FontWeight.w700),
                ),
                Consumer<WishlistNotifier>(
                  builder: (context, notifier, _) => IconButton(
                    icon: Icon(
                      notifier._wishlist.any((item) => item["id"] == data["id"])
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: notifier._wishlist
                              .any((item) => item["id"] == data["id"])
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
          ),
          ListTile(
            title: Text("Deskripsi",
                style: Theme.of(context).textTheme.titleSmall),
            subtitle: Text(
              """Creates a text widget.If the [style] argument is null, 
          the text will use the style from the closest enclosing 
          The [overflow] property's behavior is affected by the [softWrap] argument.
          If the [softWrap] is true or null, the glyph causing overflow, and those that follow,
          will not be rendered. Otherwise, it will be shown with the given overflow option""",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          ListTile(
            title:
                Text("Kondisi", style: Theme.of(context).textTheme.titleSmall),
            subtitle: Text("Baru",
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

class WishlistNotifier extends ChangeNotifier {
  final Set<Map<String, String>> _wishlist = {};

  void toggleWishlist(Map<String, String> data) {
    var id = data["id"];
    if (_wishlist.any((item) => item["id"] == id)) {
      _wishlist.removeWhere((item) => item["id"] == id);
    } else {
      _wishlist.add(data);
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
        child: Text('wishlist kosong'),
      );
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
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
