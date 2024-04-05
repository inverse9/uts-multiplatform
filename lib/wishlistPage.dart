import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    int crossAxisCount = _getScreenSizeCategory(screenWidth);
    var appState = context.watch<WishlistNotifier>();
    if (appState._wishlist.isEmpty) {
      return Center(
        child: Text('wishlist kosong'),
      );
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: appState._wishlist.length,
      itemBuilder: (context, index) {
        var film = appState._wishlist.toList()[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  data: film,
                  index: index,
                ),
              ),
            );
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "../assets/img/${film["img"]!}",
                  fit: BoxFit.cover,
                ),
                Text(film["title"]!),
              ],
            ),
          ),
        );
      },
    );
  }

  int _getScreenSizeCategory(double screenWidth) {
    if (screenWidth < 600) {
      return 2; // For screen widths less than 600
    } else if (screenWidth >= 600 && screenWidth < 960) {
      return 3; // For screen widths between 600 and 960
    } else if (screenWidth >= 960 && screenWidth < 1280) {
      return 4; // For screen widths between 960 and 1280
    } else {
      return 2;
    }
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
      body: MediaQuery.of(context).size.width > 600
          ? DetailPageWeb(data: data)
          : DetailPageMobile(data: data),
    );
  }
}

class DetailPageWeb extends StatelessWidget {
  const DetailPageWeb({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, String> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, // Adjust width as needed
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "../assets/img/${data["img"]!}",
            fit: BoxFit.cover,
          ),
          SizedBox(width: 16), // Add spacing between the image and column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data["title"]!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize:
                              Theme.of(context).textTheme.headline6?.fontSize,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Consumer<WishlistNotifier>(
                        builder: (context, notifier, _) => IconButton(
                          icon: Icon(
                            notifier._wishlist
                                    .any((item) => item["id"] == data["id"])
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
                  title: Text("Genres: ",
                      style: Theme.of(context).textTheme.subtitle1),
                  subtitle: Text(data["genres"]!,
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ),
                ListTile(
                  title: Text("Deskripsi",
                      style: Theme.of(context).textTheme.subtitle1),
                  subtitle: Text(data["desc"]!,
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ),
                ListTile(
                  title: Text("Release Date:",
                      style: Theme.of(context).textTheme.subtitle1),
                  subtitle: Text(data["release"]!,
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ),
                ListTile(
                  title: Text("Run Time:",
                      style: Theme.of(context).textTheme.subtitle1),
                  subtitle: Text(data["runTime"]!,
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailPageMobile extends StatelessWidget {
  const DetailPageMobile({
    super.key,
    required this.data,
  });

  final Map<String, String> data;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.asset(
          "../assets/img/${data["img"]!}",
          fit: BoxFit.cover,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data["title"]!,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
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
          title:
              Text("Genres: ", style: Theme.of(context).textTheme.titleSmall),
          subtitle: Text(data["genres"]!,
              style: TextStyle(color: Colors.grey, fontSize: 12)),
        ),
        ListTile(
          title:
              Text("Deskripsi", style: Theme.of(context).textTheme.titleSmall),
          subtitle: Text(
            data["desc"]!,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
        ListTile(
          title: Text("Release Date:",
              style: Theme.of(context).textTheme.titleSmall),
          subtitle: Text(data["release"]!,
              style: TextStyle(color: Colors.grey, fontSize: 12)),
        ),
        ListTile(
          title:
              Text("Run Time:", style: Theme.of(context).textTheme.titleSmall),
          subtitle: Text(data["runTime"]!,
              style: TextStyle(color: Colors.grey, fontSize: 12)),
        ),
      ],
    );
  }
}
