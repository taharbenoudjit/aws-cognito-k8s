import 'package:flutter/material.dart';
import '../Screens/Login/UI/login_page.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/auth':
        return MaterialPageRoute(
            builder: (_) => const LoginPage(title: 'AWS Cognito'));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
