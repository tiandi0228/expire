import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryList {
  int id;
  String name;

  CategoryList({
    required this.id,
    required this.name,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class CategoryModel {
  List<CategoryList> list;

  CategoryModel({
    required this.list,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        list: List<CategoryList>.from(
          json['list'].map(
            (x) => CategoryList.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "list": list,
      };
}
