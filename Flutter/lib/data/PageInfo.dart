import 'package:flutter/material.dart';

class PageInfo {
  PageInfo({@required this.title, @required this.icon, @required this.page}) : super();

  String title;
  Icon icon;
  Widget page;
}