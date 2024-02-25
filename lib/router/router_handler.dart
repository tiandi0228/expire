import 'package:expire/screens/create/create_screen.dart';
import 'package:expire/screens/home/home_screen.dart';
import 'package:expire/screens/login/login_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

// 首页
var homeScreenHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const HomeScreen();
});

// 登录
var loginScreenHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const LoginScreen();
});

// 新建
var createScreenHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const CreateScreen();
});
