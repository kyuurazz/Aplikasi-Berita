## Profile
| #               | Biodata              |
| --------------- | ---------------------|
| **Nama**        | Bilal AlHafidz       |
| **NIM**         | 312110397            |
| **Kelas**       | TI.21.A.1            |
| **Mata Kuliah** | Pemrograman Mobile 2 |

## Daftar Isi

- [Profile](#profile)
- [Daftar Isi](#daftar-isi)
- [Requirements](#requirements)
- [Informasi](#informasi)
- [Tutorial](#tutorial)

# Requirements
- [Flutter](https://docs.flutter.dev/get-started/install)

# Informasi

<p align="center">
 <img src="img/news-api.png"/>
</p>

<p>Apa itu News API?</p>
<p>
API News adalah Application Programming Interface (API) yang digunakan untuk mengakses dan mengambil data berita dari berbagai sumber berita secara otomatis. Dengan menggunakan API News, developer dapat mengintegrasikan data berita ke dalam aplikasi, situs web, atau layanan lainnya.
</p>

# Tutorial
- Pertama, Download Flutter sesuai dengan spesifikasi atau persyaratan komputer kalian.

|  Operating System  |                               URL                              |
| -------------------|:--------------------------------------------------------------:|
|  Windows           |  [Link](https://docs.flutter.dev/get-started/install/windows)  |
|  macOS             |  [Link](https://docs.flutter.dev/get-started/install/macos)    |
|  Linux             |  [Link](https://docs.flutter.dev/get-started/install/linux)    |
|  ChromeOS          |  [Link](https://docs.flutter.dev/get-started/install/chromeos) |

- Kemudian, masuk ke halaman [News API](https://newsapi.org/) dan klik pada tombol "Get API Key" di bagian atas kanan halaman.
- Daftar dengan akun kalian atau masuk jika kalian sudah memiliki akun.
- Setelah mendaftar/masuk, kalian akan diarahkan ke dashboard NewsAPI.
- Kemudian, buat project baru dalam direktori anda dengan nama yang kalian inginkan. Contoh:
  
```bash
flutter create news-app
```

- Lalu, pada direktori lib > main.dart hapus semua kode, kemudian ubah dengan kode ini:

```dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(NewsApp());
}

class NewsApp extends StatefulWidget {
  @override
  _NewsAppState createState() => _NewsAppState();
}

class NewsDetailScreen extends StatelessWidget {
  final dynamic article;

  const NewsDetailScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article['urlToImage'] != null)
                Image.network(
                  article['urlToImage'],
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 16),
              Text(
                article['title'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                article['description'] != null
                    ? article['description']
                    : 'No description available',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Published At: ${article['publishedAt']}',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Text(
                'Source: ${article['source']['name']}',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Text(
                'Read More: ${article['url']}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewsAppState extends State<NewsApp> {
  List<dynamic> articles = [];

  Future<void> fetchNews() async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=id&apiKey="APIKEY ANDA"';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        articles = jsonData['articles'];
      });
    } else {
      print('Error fetching news.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('News App'),
        ),
        body: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                leading: articles[index]['urlToImage'] != null
                    ? Image.network(
                        articles[index]['urlToImage'],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : SizedBox.shrink(),
                title: Text(articles[index]['title']),
                subtitle: Text(articles[index]['description'] ??
                    'No description available'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDetailScreen(
                        article: articles[index],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
```

- Kemudian, tambahkan `APIKEY` kalian dalam url.

```dart
    String url =
        'https://newsapi.org/v2/top-headlines?country=id&apiKey=apikey_anda'; //Masukan APIKEY kalian disini
    var response = await http.get(Uri.parse(url));
```

- Dan jangan lupa menambahkan Library http pada file `pubspec.yaml`.

```dart
dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.3
```

- Buka terminal, Kemudian run command `flutter pub get`.
- Setelah selesai, jalankan programnya with debugging.
- Maka hasilnya akan seperti ini :>

![Output](img/output.png.png)

- Kode diatas dapat kalian improvisasi dengan kreasi kalian sendiri.

## Terima Kasih!