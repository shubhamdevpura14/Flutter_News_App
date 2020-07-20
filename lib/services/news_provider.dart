import 'dart:convert';

import 'package:news_app/models/api_model.dart';
import 'package:http/http.dart' as http;

class NewsApiProvider {
  String baseUrl =
      "https://newsapi.org/v2/top-headlines?country=in&apiKey=dc7f3ccfb1714fa89c6a301b2cc6652b";
  final successCode = 200;

  Future<List<Articles>> fetchHeadlines() async {
    final response = await http.get(baseUrl);

    return parseResponse(response);
  }

  Future<List<Articles>> fetchHeadlinesByCategory(String category) async {
    final response = await http.get(baseUrl + "&category=" + category);

    return parseResponse(response);
  }

  List<Articles> parseResponse(http.Response response) {
    final responseString = jsonDecode(response.body);

    if (response.statusCode == successCode) {
      return ApiResult.fromJson(responseString).articles;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
