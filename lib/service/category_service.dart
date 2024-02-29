import 'package:expire/models/category_model.dart';
import 'package:expire/server/base.dart';

// 分类列表
class CategoryAPI {
  // 获取详情信息
  static Future<CategoryModel> getCategoryData() async {
    var res = await RequestUtil().get('category');

    final Map<String, dynamic> data = {"list": []};

    for (var item in res) {
      data['list'].add(item);
    }

    return CategoryModel.fromJson(data);
  }
}
