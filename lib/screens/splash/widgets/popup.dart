import 'dart:io';

import 'package:expir/screens/home/home_screen.dart';
import 'package:expir/store/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:uni_platform/uni_platform.dart';
import 'package:window_manager/window_manager.dart';

class Popup extends StatefulWidget {
  const Popup({super.key});

  @override
  State<StatefulWidget> createState() => _PopupState();
}

class _PopupState extends State<Popup>
    with WidgetsBindingObserver, TrayListener, WindowListener {
  Brightness _brightness = Brightness.light;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    if (UniPlatform.isWindows || UniPlatform.isLinux || UniPlatform.isMacOS) {
      trayManager.addListener(this);
      windowManager.addListener(this);
      _init();
    }
    super.initState();
    UniPlatform.call<Future<void>>(
      desktop: () => _initWindow(),
      otherwise: () => Future(() => null),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (UniPlatform.isWindows || UniPlatform.isMacOS || UniPlatform.isLinux) {
      trayManager.removeListener(this);
      windowManager.removeListener(this);
    }
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    Brightness newBrightness =
        // ignore: deprecated_member_use
        WidgetsBinding.instance.window.platformBrightness;
    debugPrint('change $_brightness');
    if (newBrightness != _brightness) {
      _brightness = newBrightness;
      if (UniPlatform.isMacOS || UniPlatform.isWindows) {
        _initTrayIcon();
      }
      setState(() {});
    }
  }

  Future<void> _init() async {
    // 初始化托盘图标
    await _initTrayIcon();
    await _initData();
    setState(() {});
  }

  // 初始化数据
  Future<void> _initData() async {
    LocalStorage.initSP();
  }

  // 初始化Tray
  Future<void> _initTrayIcon() async {
    if (UniPlatform.isWeb) return;
    String trayIcon = 'assets/icon/tray_dark.png';
    if (_brightness == Brightness.dark) {
      trayIcon = 'assets/icon/tray_light.png';
    }

    await trayManager.destroy();
    await trayManager.setIcon(
      trayIcon,
      isTemplate: UniPlatform.isMacOS ? true : false,
    );
    await Future.delayed(const Duration(milliseconds: 10));
    // 新建菜单
    List<MenuItem> items = [
      MenuItem(key: 'open', label: '显示/隐藏'),
      MenuItem.separator(),
      MenuItem(key: 'quit', label: '退出'),
    ];
    // 设置系统托盘菜单
    await trayManager.setContextMenu(Menu(items: items));
  }

  // 初始化窗口
  Future<void> _initWindow() async {
    // 必须加上这一行。
    await windowManager.ensureInitialized();
    const size = Size(350, 500);
    await Future.any([
      windowManager.setSize(size),
      windowManager.setSkipTaskbar(true),
      windowManager.setTitleBarStyle(
        TitleBarStyle.hidden,
        windowButtonVisibility: true,
      ),
      windowManager.setPreventClose(true),
    ]);
    await Future<void>.delayed(const Duration(milliseconds: 200));
    await windowManager.hide();
  }

  // 隐藏
  Future<void> _windowHide() async {
    await windowManager.hide();
  }

  // 显示
  Future<void> _windowShow({
    bool isShowTray = false,
  }) async {
    if (UniPlatform.isMacOS || isShowTray) {
      Rect? trayIconBounds = await trayManager.getBounds();
      Size windowSize = await windowManager.getSize();
      if (trayIconBounds != null) {
        Size trayIconSize = trayIconBounds.size;
        Offset trayIconPosition = trayIconBounds.topLeft;
        Offset newPosition = Offset(
          trayIconPosition.dx - ((windowSize.width - trayIconSize.width) / 2),
          trayIconPosition.dy,
        );
        debugPrint('Offset: , $newPosition');
        windowManager.setPosition(newPosition);
      }
    }

    await Future.delayed(const Duration(milliseconds: 300));
    bool isVisible = await windowManager.isVisible();
    if (!isVisible) {
      await windowManager.show();
    } else {
      await windowManager.focus();
    }
  }

  @override
  void onTrayIconMouseDown() async {
    debugPrint('鼠标按下');
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayIconRightMouseDown() {
    debugPrint('鼠标右键按下');
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) async {
    switch (menuItem.key) {
      case 'open':
        debugPrint('隐藏');
        await Future.delayed(const Duration(milliseconds: 300));
        bool isVisible = await windowManager.isVisible();
        if (isVisible) {
          _windowHide();
        } else {
          _windowShow();
        }
        break;
      case 'quit':
        debugPrint('退出');
        await trayManager.destroy();
        exit(0);
    }
  }

  @override
  void onWindowClose() async {
    debugPrint('关闭窗口');
    await Future.delayed(const Duration(milliseconds: 300));
    _windowHide();
  }

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
