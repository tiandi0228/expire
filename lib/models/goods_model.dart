class GoodsModel {
  String name;
  String manufactureDate;
  String qualityGuaranteePeriod;
  String categoryName;
  String icon;

  GoodsModel({
    required this.name,
    required this.manufactureDate,
    required this.qualityGuaranteePeriod,
    required this.categoryName,
    required this.icon,
  });

  factory GoodsModel.fromJson(Map<String, dynamic> json) => GoodsModel(
        name: json["name"],
        manufactureDate: json['manufacture_date'],
        qualityGuaranteePeriod: json['quality_guarantee_period'],
        categoryName: json['category_name'],
        icon: json['icon'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "manufactureDate": manufactureDate,
        "qualityGuaranteePeriod": qualityGuaranteePeriod,
        "categoryName": categoryName,
        "icon": icon,
      };
}
