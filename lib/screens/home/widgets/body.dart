import 'package:expire/models/goods_model.dart';
import 'package:expire/models/home_model.dart';
import 'package:expire/screens/home/widgets/item.dart';
import 'package:expire/service/home_service.dart';
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
  List<GoodsModel> items = [];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    HomeModel res = await HomeAPI.getHomeData(page: 1, pageSize: 10);
    setState(() {
      items = res.goodsList;
    });
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
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Item(data: items[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
