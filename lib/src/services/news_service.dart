import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:http/http.dart' as http;

const String _URL_NEWS = 'https://newsapi.org/v2';
const String _APIKEY = '7e35f26cdac543eaa226edd9d8844088';

class NewsService extends ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';
  bool isLoading = false;

  List<Category> categories = [
    Category(icon: FontAwesomeIcons.building, name: 'business'),
    Category(icon: FontAwesomeIcons.tv, name: 'entertainment'),
    Category(icon: FontAwesomeIcons.addressCard, name: 'general'),
    Category(icon: FontAwesomeIcons.headSideVirus, name: 'health'),
    Category(icon: FontAwesomeIcons.vials, name: 'science'),
    Category(icon: FontAwesomeIcons.volleyball, name: 'sports'),
    Category(icon: FontAwesomeIcons.memory, name: 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {
    'general': [],
  };

  NewsService() {
    getTopHeadlines();
    for (var element in categories) {
      categoryArticles[element.name] = [];
    }
  }

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String category) {
    _selectedCategory = category;
    getArticlesByCategory(category);
    notifyListeners();
  }

  List<Article> get getArticlesSelectedCategory =>
      categoryArticles[selectedCategory]!;

  getTopHeadlines() async {
    final url = Uri.parse(
        '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=mx&category=business');

    final resp = await http.get(url);
    final newResponse = newResponseFromJson(resp.body);

    headlines.addAll(newResponse.articles); // agregar los articulos
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      return categoryArticles[category];
    }

    isLoading = true;

    final url = Uri.parse(
        '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=mx&category=$category');

    final resp = await http.get(url);
    final newResponse = newResponseFromJson(resp.body);

    categoryArticles[category]?.addAll(newResponse.articles);
    notifyListeners();
    isLoading = false;
  }
}
