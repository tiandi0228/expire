import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:expire/store/local_storage.dart';
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
  void _onLogin(BuildContext context) async {
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
                _buildPhoneInput(),
                const Padding(padding: EdgeInsets.only(top: 20)),
                _buildPasswordInput(),
                const Padding(padding: EdgeInsets.only(top: 20)),
                _buildSubmit(context),
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

  // 手机号码
  Widget _buildPhoneInput() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      padding: EdgeInsets.zero,
      child: TextFormField(
        controller: _usernameController,
        keyboardType: TextInputType.visiblePassword,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38,
              width: 0.5,
            ),
          ),
          hintText: "请输入密码",
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.black26,
          ),
        ),
        cursorColor: Colors.black,
      ),
    );
  }

  // 密码
  Widget _buildPasswordInput() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      padding: EdgeInsets.zero,
      child: TextFormField(
        controller: _pwdController,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38,
              width: 0.5,
            ),
          ),
          hintText: "请输入密码",
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Colors.black26,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                hidden = !hidden;
              });
            },
            icon: Icon(
              hidden
                  ? Icons.remove_red_eye_rounded
                  : Icons.remove_red_eye_outlined,
            ),
          ),
        ),
        obscureText: hidden,
        cursorColor: Colors.black,
      ),
    );
  }

  // 登录按钮
  Widget _buildSubmit(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      padding: EdgeInsets.zero,
      child: TextButton(
        onPressed: () => _onLogin(context),
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(100, 40)),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          backgroundColor: MaterialStateProperty.all(const Color(0xFFFFD470)),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        child: const Text(
          '登录',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
