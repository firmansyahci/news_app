import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/news.dart';

class NewsController extends GetxController {
  var news = <Article>[].obs;
  var page = 1.obs;
  var isLoading = false.obs;
  var isListEnd = false.obs;

  var pageSize = 10;

  late ScrollController scrollController;

  getLatestNews(int page) async {
    if (page <= 1) {
      isLoading(true);
    }

    final url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=id&page=$page&pageSize=10&apiKey=5f00d331dfd24c32a3e34d70cae204b6');
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      if (page > 1) {
        news.addAll(newsFromJson(response.body).articles!);
      } else {
        news.value = newsFromJson(response.body).articles!;
      }
    }
    isListEnd(newsFromJson(response.body).articles!.length < pageSize);
    isLoading(false);
  }

  @override
  void onInit() {
    super.onInit();
    getLatestNews(page.value);
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isListEnd.value) {
        page.value++;
        getLatestNews(page.value);
      }
    });
  }
}
