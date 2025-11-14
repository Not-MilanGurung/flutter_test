import 'package:flutter/material.dart';
import 'package:cis099_2/core/newsapicall.dart';
import 'package:cis099_2/core/static.dart';
import 'package:cis099_2/model/newsapi.dart';
import 'package:cis099_2/routes.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<NewsApi?> futureNewsApiHorizontal;
  late Future<NewsApi?> futureNewsApiVertical;

  @override
  void initState() {
    super.initState();
    futureNewsApiHorizontal = NewsApiCall().getnewsdata('Tesla');
    futureNewsApiVertical = NewsApiCall().getnewsdata('Nepal');
  }

  horizontalCard(Size size, Articles article) {
    String heading = article.title ?? "";
    String date = article.publishedAt ?? "";
    String imageURL = article.urlToImage ?? "";
    return GestureDetector(
      onTap: () {
        StaticValue.clickedArticle = article;
        Navigator.of(context).pushNamed(AppRoute.detailPage);
      },
      child: Stack(
        children: [
          Container(
            height: size.height / 5,
            width: size.width / 1.5,
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                imageURL,
                fit: BoxFit.fill,
                errorBuilder:
                    (
                      BuildContext context,
                      Object exception,
                      StackTrace? stackTrace,
                    ) {
                      return Image.network(
                        StaticValue.noImageFoundURL,
                        fit: BoxFit.fill,
                      );
                    },
                opacity: const AlwaysStoppedAnimation(.7),
              ),
            ),
          ),
          Container(
            height: size.height / 5,
            width: size.width / 1.5,
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.black,
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [Colors.black, Colors.transparent],
              ),
            ),
          ),

          Positioned(
            bottom: 15,
            left: 15,
            width: size.width / 1.5,
            child: Column(
              children: [
                Text(
                  heading,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 5,
                        offset: Offset(0.0, 0.0),
                      ),
                    ],
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 15,
            bottom: 15,
            child: Icon(Icons.play_circle, color: Colors.white, size: 30),
          ),
        ],
      ),
    );
  }

  getHorozintalCards(NewsApi newsApi, size) {
    return Container(
      padding: EdgeInsetsGeometry.only(left: 6, right: 6),
      height: size.height / 5,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: newsApi.articles!.length,
        itemBuilder: (BuildContext context, int index) {
          return horizontalCard(size, newsApi.articles![index]);
        },
      ),
    );
  }

  getVerticalCards(NewsApi newsApi, size) {
    return Container(
      padding: EdgeInsetsGeometry.only(top: 12, bottom: 12),
      height: size.height / 1.5,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return verticalCard(size, 'More', newsApi.articles![index]);
        },
      ),
      // child: ListView.builder(
      //   shrinkWrap: true,
      //   itemCount: newsApi.articles!.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return verticalCard(size, 'More', newsApi.articles![index]);
      //   },
      // ),
    );
  }

  verticalCard(Size size, buttonText, Articles article) {
    String heading = article.title!;
    String date = article.publishedAt!;
    String imageURL = article.urlToImage!;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              StaticValue.clickedArticle = article;
              Navigator.of(context).pushNamed(AppRoute.detailPage);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 100,
                  width: 160,
                  margin: EdgeInsets.only(right: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      imageURL,
                      fit: BoxFit.fill,
                      errorBuilder:
                          (
                            BuildContext context,
                            Object exception,
                            StackTrace? stackTrace,
                          ) {
                            return Image.network(
                              StaticValue.noImageFoundURL,
                              fit: BoxFit.fill,
                            );
                          },
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 120,
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(Icons.play_circle, color: Colors.red, size: 40),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width / 1.8,
                child: Text(
                  heading,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              // SizedBox(height: 20),
              SizedBox(
                width: size.width / 1.8,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        buttonText,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        date,
                        style: TextStyle(color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          FutureBuilder<NewsApi?>(
            future: futureNewsApiHorizontal,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.active:
                  break;
                case ConnectionState.waiting:
                  break;
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    NewsApi? data = snapshot.data;
                    return getHorozintalCards(data!, size);
                  }
              }
              return Center(child: const CircularProgressIndicator());
            },
          ),

          FutureBuilder<NewsApi?>(
            future: futureNewsApiVertical,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return getVerticalCards(snapshot.data!, size);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
