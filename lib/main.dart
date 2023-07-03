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
        'https://newsapi.org/v2/top-headlines?country=id&apiKey=apikey_anda';
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
