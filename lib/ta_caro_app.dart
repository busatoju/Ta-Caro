import 'package:flutter/material.dart';
import 'package:ta_caro/modules/feed/feed_view.dart';
import 'package:ta_caro/modules/home/home_view.dart';
import 'package:ta_caro/modules/splash/splash_view.dart';
import 'modules/login/create_account/create_account_view.dart';
import 'modules/login/login_view.dart';
import 'modules/settings/profile_view.dart';
import 'shared/models/user_model.dart';

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
        '/login': (context) => const LoginView(),
        '/createAccount': (context) => const CreateAccountView(),
        '/home': (context) {
          UserModel user =
              ModalRoute.of(context)!.settings.arguments as UserModel;
          return HomeView(
            user: user,
            views: [
              FeedView(user: user),
              ProfileView(
                user: user,
              ),
            ],
          );
        },
      },
    );
  }
}
