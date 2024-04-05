import 'package:flutter/material.dart';

import 'gridPage.dart';
import 'wishlistPage.dart';

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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Menu',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                setState(() {
                  currentPageIndex = 0;
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text('Wishlist'),
              onTap: () {
                setState(() {
                  currentPageIndex = 1;
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: [GridPage(), WishlistPage()][currentPageIndex],
      bottomNavigationBar: MediaQuery.of(context).size.width > 600
          ? null
          : NavigationBar(
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
    );
  }
}
