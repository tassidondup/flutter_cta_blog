import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'posts.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // var posts;

  @override
  void initState() {
    super.initState();
    // getPosts();
  }

  // A function that converts response body into a List of Posts(object or class) as in this particular case.
  List<Posts> parsePosts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Posts>((json) => Posts.fromJson(json)).toList();
  }

  // A function that fetch 10 latest wp posts from wp rest api
  Future<List<Posts>> fetchPosts() async {
    http.Response response = await http.get('https://tibet.net/wp-json/wp/v2/posts');

    if (response.statusCode == 200) {
      return parsePosts(response.body);
      // return compute(parsePosts(response.body));
    } else {
      print(response.statusCode);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // posts = fetchPosts();
    // print(posts);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(),
      body: FutureBuilder<List<Posts>>(
        future: fetchPosts(),
        builder: (context, posts) {
          if (posts.hasError) print(posts.error);

          return posts.hasData
              ? PostsList(posts: posts.data)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class PostsList extends StatelessWidget {
  final List<Posts> posts;
  PostsList({Key key, this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          // color: Colors.yellowAccent,
          // height: double.infinity,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${posts[index].title}', style: TextStyle(fontSize: 16.0, ),),
              ),
            ],
          ),
        );
      },
    );
  }
}
