import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controller/news_controller.dart';
import 'package:news_app/widgets/headline_item.dart';

class HomeScreen extends StatelessWidget {
  final NewsController newsC = Get.put(NewsController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(),
        body: newsC.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  // Headline Big Pic
                  Container(),
                  // Grid headline
                  Container(
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: HeadlineItem(
                              newsC.news[1].urlToImage!,
                              newsC.news[1].title!,
                              newsC.news[1].description!,
                            ),
                          ),
                          Expanded(
                            child: HeadlineItem(
                              newsC.news[1].urlToImage!,
                              newsC.news[1].title!,
                              newsC.news[1].description!,
                            ),
                          ),
                          Expanded(
                            child: HeadlineItem(
                              newsC.news[1].urlToImage!,
                              newsC.news[1].title!,
                              newsC.news[1].description!,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Lastest News
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        newsC.page.value = 1;
                        newsC.getLatestNews(newsC.page.value);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                          controller: newsC.scrollController,
                          itemCount: newsC.isListEnd.value
                              ? newsC.news.length
                              : newsC.news.length + 1,
                          itemBuilder: (ctx, i) {
                            return i < newsC.news.length
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              newsC.news[i].title ?? '-',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              newsC.news[i].description ?? '-',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (newsC.news[i].urlToImage != null)
                                        SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: Image.network(
                                              newsC.news[i].urlToImage!),
                                        ),
                                    ],
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  );
                          },
                          separatorBuilder: (ctx, i) {
                            return Divider();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
