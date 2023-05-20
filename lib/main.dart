import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:two_hr_test/helper/routes/routes.dart';
import 'package:two_hr_test/helper/routes/routes_generator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String initialRoute = await findIntialRoute();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(MyApp(initialRoute)));
  configLoading();
}

Future<String> findIntialRoute() async {
  String initialRoute = Routes.home;
  return initialRoute;
}

Object? args;
class MyApp extends StatelessWidget {
  late String initialRoute;
   MyApp(this.initialRoute,{super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Test 2 hr',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
        initialRoute: Routes.home,
        debugShowCheckedModeBanner: false,
        navigatorObservers: [ClearFocusOnPush()],
        onGenerateRoute: RoutesGenerator.generateRoute,
        onGenerateInitialRoutes: (String initialRouteName) {
          return [
            RoutesGenerator.generateRoute(
                RouteSettings(name: initialRoute, arguments: args)),
          ];
        }
    );
  }
}


void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 3000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Color(0xffFE820E)
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class ClearFocusOnPush extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final focus = FocusManager.instance.primaryFocus;
    focus?.unfocus();
  }
}

