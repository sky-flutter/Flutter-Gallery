import 'package:flutter_bloc_pattern/src/models/PopularMovie.dart';

import 'movie_api_provider.dart';

class Repository {
  final movieApiProvider = MovieApiProvider();

  Future<PopularMovie> fetchPopularMovie() =>
      movieApiProvider.fetchPopularMovieList();
}
