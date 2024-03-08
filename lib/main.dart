import 'dart:io';

import 'package:expire/config/constants.dart';
import 'package:expire/router/router.dart';
import 'package:expire/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uni_platform/uni_platform.dart';
import 'package:window_manager/window_manager.dart';

Future<void> _ensureInitialized() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('Box');
  // 开机启动
  if (UniPlatform.isMacOS || UniPlatform.isWindows) {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    LaunchAtStartup.instance.setup(
      appName: packageInfo.appName,
      appPath: Platform.resolvedExecutable,
    );

    await launchAtStartup.enable();
  }

  if (UniPlatform.isLinux || UniPlatform.isMacOS || UniPlatform.isWindows) {
    await windowManager.ensureInitialized();
  }
}

void main() async {
  await _ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  MyRouter.configureRoutes(MyRouter.router);
  UniPlatform.call<Future<void>>(
    desktop: () async {
      const WindowOptions windowOptions = WindowOptions(
        alwaysOnTop: false,
        skipTaskbar: true,
        titleBarStyle: TitleBarStyle.hidden,
        windowButtonVisibility: true,
      );
      windowManager.waitUntilReadyToShow(windowOptions, () async {
        if (UniPlatform.isMacOS) {
          await windowManager.setVisibleOnAllWorkspaces(
            false,
            visibleOnFullScreen: false,
          );
          await windowManager.setMaximizable(false);
          await windowManager.setMinimizable(false);
          await windowManager.setResizable(false);
        }
      });
    },
    otherwise: () => Future(() => null),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('zh', ''),
      ],
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
      ),
      onGenerateRoute: MyRouter.router.generator,
      home: const SplashScreen(),
    );
  }
}
