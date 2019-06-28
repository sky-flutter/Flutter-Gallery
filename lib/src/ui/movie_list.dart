import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/src/blocs/movie_bloc.dart';
import 'package:flutter_bloc_pattern/src/models/PopularMovie.dart';
import 'package:flutter_bloc_pattern/src/models/results.dart';
import 'package:flutter_bloc_pattern/src/ui/view_image.dart';

class MovieList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MovieListState();
  }
}

class MovieListState extends State<MovieList>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = false;
  MovieBloc bloc = new MovieBloc();
  List<Results> listMovies = new List();
  ScrollController _scrollController = new ScrollController();

  setLoading(bool isLoad) {
    setState(() {
      isLoading = isLoad;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        setLoading(true);
        bloc.fetchAllMovies();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setLoading(true);
    bloc.fetchAllMovies();
    return Scaffold(
      body: StreamBuilder(
        builder: (context, AsyncSnapshot<PopularMovie> snapshot) {
          if (snapshot.hasData) {
            listMovies.addAll(snapshot.data.results);
            return buildList();
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return _buildProgressIndicator();
        },
        stream: bloc.movieFetch,
      ),
    );
  }

  Widget buildList() {
    double leftMargin=0,rightMargin=0;
    return Builder(
      builder: (context) {
        return GridView.builder(
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            controller: _scrollController,
            itemCount: listMovies.length + 1,
            itemBuilder: (context, index) {
              if (index == listMovies.length) {
                return _buildProgressIndicator();
              } else {
                if(index%3==0){
                  leftMargin=8;
                  rightMargin=0;
                }else if(index%3==1){
                  leftMargin=8;
                  rightMargin=0;
                }else {
                  leftMargin=8;
                  rightMargin=8;
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => ImageSlider(listMovies, index)));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: leftMargin,right: rightMargin,top: 8),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w342${listMovies[index].poster_path}',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }
            });
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _buildProgressIndicator() {
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      child: Opacity(
        opacity: isLoading ? 1.0 : 0.0,
        child: Center(
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}
