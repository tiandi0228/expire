import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:expire/store/local_storage.dart';
import 'package:expire/widgets/button_widget.dart';
import 'package:expire/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  bool hidden = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  // 登录
  Future<void> _onLogin(BuildContext context) async {
    if (!RegexUtil.isMobileExact(_usernameController.value.text)) {
      FToast.toast(
        context,
        duration: 800,
        msg: '请输入手机号码',
        msgStyle: const TextStyle(
          color: Colors.white,
        ),
      );
      return;
    }

    if (_pwdController.value.text.length < 6) {
      FToast.toast(
        context,
        duration: 800,
        msg: '请输入密码',
        msgStyle: const TextStyle(
          color: Colors.white,
        ),
      );
      return;
    }
    await Future.delayed(
      const Duration(milliseconds: 10),
      () => {
        LocalStorage.set('access-token', '111111111'),
        Navigator.pop(context),
        FToast.toast(
          context,
          msg: '登录成功',
          msgStyle: const TextStyle(
            color: Colors.white,
          ),
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: Color(0xFFFFF4EE),
      ),
      child: Stack(
        children: [
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height -
                (MediaQuery.of(context).size.height / 2),
            decoration: const BoxDecoration(
              color: Color(0xFFC3CFB6),
            ),
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 12)),
                HCInput(
                  controller: _usernameController,
                  hintText: '请输入手机号码',
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                HCInput(
                  controller: _pwdController,
                  hintText: '请输入密码',
                  obscureText: true,
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                HCButton(
                  onPressed: () => _onLogin(context),
                  text: '登 录',
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 12,
            child: Container(
              padding: EdgeInsets.zero,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/rabbit.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
