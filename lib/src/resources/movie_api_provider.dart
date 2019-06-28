import 'dart:convert';

import 'package:flutter_bloc_pattern/src/models/PopularMovie.dart';
import 'package:flutter_bloc_pattern/src/utils/ApiKey.dart';
import 'package:http/http.dart';

class MovieApiProvider {
  Client client = new Client();
  var page = 0;

  Future<PopularMovie> fetchPopularMovieList() async {
    page++;
    final response = await client.get(
        "http://api.themoviedb.org/3/movie/popular?api_key=${ApiKey.API_KEY}&page=$page");
    print(response.body.toString());
    if (response.statusCode == 200) {
      return PopularMovie.fromJsonMap(json.decode(response.body));
    } else {
      throw Exception("Failed to load popular movie");
    }
  }
}
