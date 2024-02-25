import 'package:expir/screens/splash/widgets/popup.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return const Popup();
  }
}
