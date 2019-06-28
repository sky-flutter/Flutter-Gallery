import 'package:flutter_bloc_pattern/src/models/PopularMovie.dart';
import 'package:flutter_bloc_pattern/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class MovieBloc {
  final repository = Repository();

  final movieFetch = PublishSubject<PopularMovie>();

  Observable<PopularMovie> get movies => movieFetch.stream;

  fetchAllMovies() async {
    PopularMovie movie = await repository.fetchPopularMovie();

    movieFetch.sink.add(movie);
  }

  dispose() {
    movieFetch.close();
  }
}

final block = MovieBloc();
