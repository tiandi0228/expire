import 'dart:convert';

import 'package:expire/models/goods_model.dart';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  int totalRecords;
  int totalPages;
  List<GoodsModel> goodsList;

  HomeModel({
    required this.totalPages,
    required this.totalRecords,
    required this.goodsList,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        totalRecords: json['total_records'],
        totalPages: json['total_pages'],
        goodsList: List<GoodsModel>.from(
          json["records"].map(
            (x) => GoodsModel.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "total_pages": totalPages,
        "total_records": totalRecords,
        "records": List<dynamic>.from(goodsList.map((x) => x.toJson())),
      };
}
