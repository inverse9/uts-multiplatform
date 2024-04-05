import 'package:flutter/material.dart';

import 'wishlistPage.dart';

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
