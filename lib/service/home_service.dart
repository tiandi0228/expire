import 'package:expire/models/home_model.dart';
import 'package:expire/server/base.dart';

class HomeAPI {
  static Future<HomeModel> getHomeData({
    String? name,
    required int page,
    required int pageSize,
  }) async {
    var res = await RequestUtil().get('product/page', params: {
      'name': name,
      'page': page,
      'pageSize': pageSize,
    });
    return HomeModel.fromJson(res);
  }
}
