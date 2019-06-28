import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/src/models/results.dart';

class ImageSlider extends StatefulWidget {
  List<Results> listResult;
  int position;

  ImageSlider(this.listResult, this.position);

  @override
  _ImageSliderState createState() => _ImageSliderState(this.listResult,this.position);
}

class _ImageSliderState extends State<ImageSlider> {
  List<Results> listResult;
  int position;
  _ImageSliderState(this.listResult, this.position);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView.builder(itemBuilder: (context,position){
          return createPage(listResult[position].poster_path);
        },itemCount: this.listResult.length,controller: PageController(initialPage: position,viewportFraction: 1,keepPage: true),),
      ),
    );
  }
  createPage(String path){
    return Image.network(
      'https://image.tmdb.org/t/p/w780${path}',
      fit: BoxFit.cover,
    );
  }

}
