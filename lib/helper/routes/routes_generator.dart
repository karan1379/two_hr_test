import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:two_hr_test/data/image_model.dart';
import 'package:two_hr_test/helper/routes/routes.dart';
import 'package:two_hr_test/home_module/home_screen.dart';
import 'package:two_hr_test/home_module/home_screen_details.dart';


class RoutesGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget widgetScreen;

    final args = settings.arguments;

    switch (settings.name) {
      case Routes.home:
        widgetScreen = HomeScreen();
        break;
      case Routes.homeDetails:
        widgetScreen = HomeScreenDetails(model: args as ImageModel);
        break;

      default:
        widgetScreen = _errorRoute();
    }
    return GetPageRoute(
        routeName: settings.name, page: () => widgetScreen, settings: settings);
  }

  static Widget _errorRoute() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('No Such screen found in route generator'),
      ),
    );
  }
}