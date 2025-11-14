import 'package:flutter/material.dart';
import 'package:cis099_2/core/newsapicall.dart';
import 'package:cis099_2/core/static.dart';
import 'package:cis099_2/model/newsapi.dart';
import 'package:cis099_2/routes.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<NewsApi?>? _futureNewsApi;

  getVerticalCards(NewsApi newsApi, size) {
    return Column(
      // padding: EdgeInsetsGeometry.only(top: 12, bottom: 12),
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: newsApi.articles!.length,
          itemBuilder: (BuildContext context, int index) {
            return verticalCard(size, 'More', newsApi.articles![index]);
          },
        ),
      ],
    );
  }

  verticalCard(size, buttonText, Articles article) {
    String heading = article.title!;
    String date = article.publishedAt!;
    return GestureDetector(
      onTap: () {
        StaticValue.clickedArticle = article;
        Navigator.of(context).pushNamed(AppRoute.detailPage);
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 100,
                  width: 120,
                  margin: EdgeInsets.only(right: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      article.urlToImage ??
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/1920px-Google_2015_logo.svg.png",
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

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width / 2,
                  child: Text(
                    heading,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: size.width / 2,
                  child: Row(
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
                      Text(date, style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  headingElement(size) {
    Articles article = StaticValue.clickedArticle!;
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: size.height / 3.5,
              width: size.width,
              child: Image.network(
                article.urlToImage ??
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/1920px-Google_2015_logo.svg.png",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: size.height / 3.5,
              width: size.width,
              decoration: BoxDecoration(color: Colors.transparent),
              child: Center(
                child: Icon(Icons.play_circle, color: Colors.red, size: 50),
              ),
            ),
            Positioned(
              left: 15,
              top: 15,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back, color: Colors.red, size: 32),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(15),
              child: Text(
                article.title!.toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(article.author ?? "Null"),
                  Text(article.publishedAt ?? "Null"),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Text(
                article.description!,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Text(
                article.content!,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _futureNewsApi = NewsApiCall().getnewsdata('Nepal');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 45),
              headingElement(size),
              FutureBuilder<NewsApi?>(
                future: _futureNewsApi,
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
        ),
      ),
    );
  }
}
