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
        title: 'Flutter UTS',
        initialRoute: '/',
        routes: {
          '/home': (context) => Home(),
          '/register': (context) => Register(),
        },
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.brown,
        ),
        home: Login(),
      ),
    );
  }
}

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 600.0,
          height: 400.0,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 12.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 12.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Register success, Redirecting to Login Screen..'),
                        duration: Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Future.delayed(Duration(seconds: 2), () {
                      Navigator.pushNamed(context, '/');
                    });
                  },
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 600.0,
          height: 400.0,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 12.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: Text('Login'),
                ),
                SizedBox(height: 12.0),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text(
                    'Click here to Register',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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

class GridPage extends StatelessWidget {
  final List<Map<String, String>> data = [
    {
      "id": "1",
      "title": "PANGGONAN WINGIT",
      "desc":
          "Berlatar tahun 1980-an, film ini diangkat dari legenda urban di daerah Semarang, Jawa Tengah. Panggonan wingit dalam bahasa Jawa berarti tempat yang sangat angker dan keramat. LSF mengklasifikasikan drama horor ini untuk penonton usia 13 tahun ke atas.",
      "img": "PF-Panggonan-Wingit-350x520.jpg",
      "runTime": "105 menit",
      "genres": "Animasi",
      "release": "20 Maret 2024"
    },
    {
      "id": "2",
      "title": "ULTRAMAN BLAZAR THE MOVIE",
      "desc":
          "Gelombang monster “Kaiju” muncul dari kawasan industri di Tokyo. Kapten Gento dan Special Kaiju Reaction Detachment (SKaRD), mencurigai adanya hubungan monster kaiju dengan Necromass Co. Sebab, perusahaan kimia canggih yang tengah meneliti bangkai kaiju, itu memiliki pabrik di kawasan industri tempat monster itu berasal. SKaRD pun menemui CEO perusahaan dan ahli kimia terkenal, Dr. Mabuse. Di fasilitas penelitian Necromass Co., Dr. Mabuse menjelaskan pengembangan Damudoxin, zat yang bisa menjamin keabadian. Sementara itu, alien Damuno, sang penguasa alam semesta, muncul. Kekacauan terjadi ketika Damudoxin bocor dari tangkinya, dan  memakan sampel bangkai kaiju. Maka muncullah Gongilgan raksasa, Bangkai Iblis. Ultraman Blazar dan SKaRD pun harus bertarung melawan kaiju raksasa!",
      "img": "PF-Ultraman-Blazar-The-Movie-Tokyo-Kaiju-Showdown-350x520.jpg",
      "runTime": "76 menit",
      "genres": "Drama Fiksi",
      "release": "9 Maret 2024"
    },
    {
      "id": "3",
      "title": "MADGAON EXPRESS",
      "desc":
          "Tiga sahabat masa kecil, Pinku (Pratik Gandhi), Ayush (Avinash Tiwari), dan Dodo (Divyenndu Sharma), memulai perjalanan ke Goa, yang telah lama mereka nantikan dengan penuh harap. Mereka membayangkan Goa sebagai destinasi yang sempurna, untuk merasakan kebebasan dan kegembiraan tak terhingga. Namun, perjalanan mereka berubah menjadi petualangan yang menguji ketahanan persahabatan mereka, dan memaksa mereka menghadapi tantangan dan kejadian mendebarkan yang tak pernah mereka bayangkan sebelumnya.",
      "img": "PF-Madgaon-Express-350x520.jpg",
      "runTime": "143 menit",
      "genres": "Action Komedi",
      "release": "22 Maret 2024"
    },
    {
      "id": "4",
      "title": "MONKEY MAN",
      "desc":
          "Terinspirasi oleh legenda Hanoman, sebagai simbol kekuatan dan keberanian, Kid (Dev Patel) seorang pegulat bayaran yang selalu mengenakan topeng gorila, menjalani hidupnya dengan bertarung. Ia rela kalah dari lawannya untuk mendapatkan uang di sebuah klub bawah tanah. Setelah bertahun-tahun menahan kemarahannya, Kid menemukan cara untuk masuk ke dalam kelompok elite jahat di kota tersebut. Selain itu, Kid juga berniat membalas dendam kepada para pemimpin korup yang telah membunuh ibunya. Film ini juga mengangkat isu sosial-politik antarkaum elite dan proletar, yang sarat kejahatan seperti: korupsi, perdagangan manusia, dan penyalahgunaan narkoba.",
      "img": "PF-Monkey-Man-350x520.jpg",
      "runTime": "119 menit",
      "genres": "Action Thriller",
      "release": "5 April 2024 (Amerika Serikat)"
    },
    {
      "id": "5",
      "title": "SHAYDA",
      "desc":
          "Shayda (Zar Amir Ebrahimi), perempuan asal Iran, tinggal di Australia bersama putrinya Mona (Selina Zahednia). Mereka berusaha melepaskan diri dari kekejaman sang suami Hossein (Osamah Sami), yang sedang menyelesaikan kuliah kedokterannya di Brisbane. Dalam usahanya untuk mendapatkan hak asuh anak dan untuk melindungi anaknya, Shayda dibantu oleh Joyce (Leah Purcell), seorang pekerja Kemanusiaan Hak-hak Prempuan dan Perlindungan Anak",
      "img": "PF-Shayda-350x520.jpeg",
      "runTime": "118 menit",
      "genres": "Drama",
      "release": "5 Oktober 2023 (Australia)"
    },
    {
      "id": "6",
      "title": "THE BIRTH OF KITARO",
      "desc":
          "Mizuki (pengisi suara Hidenobu Kuici) seorang karyawan yang juga mantan tentara, memiliki misi khusus ke desa Yagura, karena banyaknya warga yang dibunuh secara tidak wajar. Bersama Medame-Oyaji (Masako Nozawa), ayah Kitaro, Mizuki berupaya memecahkan misteri di desa yang dipimpin klan Ryuga, yang memiliki pengaruh politik dan bisnis di situ.",
      "img": "PF-The-Birth-Of-Kitaro-Mistery-Of-Gegege-350x520.jpg",
      "runTime": "105 menit",
      "genres": "Animasi",
      "release": "20 Maret 2024"
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    int crossAxisCount = _getScreenSizeCategory(screenWidth);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Film',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        leading: MediaQuery.of(context).size.width < 600
            ? null
            : IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
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
            child: Image.asset(
              "../assets/img/${data[index]["img"]!}",
              fit: BoxFit.cover,
            ),
          );
        },
      ),
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
