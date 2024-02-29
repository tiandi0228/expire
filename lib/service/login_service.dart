import 'package:expire/models/user_model.dart';
import 'package:expire/server/base.dart';

// 登录
class LoginAPI {
  static Future<dynamic> getCreateData({
    required String phone,
    required String password,
  }) async {
    var res = await RequestUtil().post('login', params: {
      "phone": phone,
      "password": password,
    });

    return UserModel.fromJson(res);
  }
}
