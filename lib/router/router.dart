import 'dart:developer' as developer;

import 'package:expir/router/router_handler.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class MyRouter {
  static FluroRouter router = FluroRouter();
  static String homeScreen = '/home'; // 首页
  static String loginScreen = '/login'; // 登录
  static String createScreen = '/create'; // 新建

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      developer.log("ROUTE WAS NOT FOUND !!!");
      return;
    });
    router.define(
      homeScreen,
      handler: homeScreenHandler,
      transitionType: TransitionType.inFromLeft,
    );
    router.define(
      loginScreen,
      handler: loginScreenHandler,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      createScreen,
      handler: createScreenHandler,
      transitionType: TransitionType.fadeIn,
    );
  }
}
