import 'package:cis099_2/views/chatapp/chats.dart';
import 'package:cis099_2/views/chatapp/conversations.dart';
import 'package:cis099_2/views/esewa/esewapage.dart';
import 'package:cis099_2/views/login.dart';
import 'package:cis099_2/views/maps/mapspage.dart';
import 'package:cis099_2/views/news/dashboard.dart';
import 'package:cis099_2/views/news/detailPage.dart';
import 'package:cis099_2/views/webview.dart';

class AppRoute {
  AppRoute._();
  static const String login = "/";
  static const String dashboard = "/dashboard";
  static const String detailPage = "/detailPage";
  static const String conversation = "/conversation";
  static const String chats = "/chats";
  static const String esewa = "/esewa";
  static const String maps = "/mpas";
  static const String webview = "/webview";

  static dynamic getAppRoutes() => {
    login: (context) => const Login(),
    dashboard: (context) => const Dashboard(),
    detailPage: (context) => const DetailPage(),
    conversation: (context) => const Conversations(),
    chats: (context) => const Chats(),
    esewa: (context) => const Esewapage(),
    maps: (context) => const MapsPage(),
    webview: (context) => const Webview(),
  };
}
