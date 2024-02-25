import 'package:expire/screens/home/widgets/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];

  // 加载更多
  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    items.add((items.length + 1).toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, bottom: 10),
      child: AnimationLimiter(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: const SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Item(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
