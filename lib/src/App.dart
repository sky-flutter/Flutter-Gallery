import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/src/ui/movie_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Gallery"),
        ),
        body: MovieList(),
      ),
    );
  }
}
