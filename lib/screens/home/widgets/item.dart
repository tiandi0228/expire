import 'package:common_utils/common_utils.dart';
import 'package:expire/models/goods_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Item extends StatefulWidget {
  GoodsModel data;

  Item({super.key, required this.data});

  @override
  State<StatefulWidget> createState() {
    return _ItemState();
  }
}

class _ItemState extends State<Item> {
  late GoodsModel _data;

  @override
  void initState() {
    super.initState();
    setState(() {
      _data = widget.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCategory(),
                _buildExpire(),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              _data.name,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 分类
  Widget _buildCategory() {
    return Container(
      padding: const EdgeInsets.only(
        left: 3,
        right: 3,
        top: 1,
        bottom: 3,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icon/${_data.icon}.svg",
            width: 20,
            height: 20,
          ),
          const Padding(padding: EdgeInsets.only(left: 5)),
          Text(
            _data.categoryName,
            style: const TextStyle(
              color: Color(0xFF9A9A9A),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // 有效期
  Widget _buildExpire() {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: "有效期:",
            style: TextStyle(
              color: Colors.black38,
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: DateUtil.formatDateStr(
              _data.qualityGuaranteePeriod,
              format: "yyyy年M月d日",
            ),
            style: const TextStyle(
              color: Colors.black26,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
