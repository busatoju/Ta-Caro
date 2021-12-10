import 'package:flutter/material.dart';
import 'package:ta_caro/modules/login/login_view.dart';
import 'package:ta_caro/shared/theme/theme_app.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then(
      (value) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginView(),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: ThemeApp.colors.background,
      body: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
