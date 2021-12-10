import 'package:flutter/material.dart';
import 'package:ta_caro/modules/home/home_view.dart';
import 'package:ta_caro/modules/splash/splash_view.dart';
import 'modules/login/create_account/create_account_view.dart';
import 'modules/login/login_view.dart';

class TaCaroApp extends StatelessWidget {
  const TaCaroApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashView(),
        '/login': (context) =>  const LoginView(),
        '/createAccount': (context) =>  const CreateAccountView(),
        '/home': (context) =>  const HomeView(),
      },
    );
  }
}
