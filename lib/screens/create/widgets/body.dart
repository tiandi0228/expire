import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 10),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/login');
        },
        child: Text('添加'),
      ),
    );
  }
}
