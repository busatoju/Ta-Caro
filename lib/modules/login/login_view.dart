import 'package:flutter/material.dart';
import 'package:ta_caro/modules/login/login_controller.dart';
import 'package:ta_caro/shared/widgets/button_widget.dart';
import 'package:ta_caro/shared/widgets/input_widget.dart';
import 'package:validators/validators.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _controller = LoginController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _controller.addListener(() {
      _controller.state.when(
          success: (value) => Navigator.pushReplacementNamed(context, '/home'),
          error: (message, _) => scaffoldKey.currentState!.showBottomSheet(
              (context) => BottomSheet(
                  onClosing: () {},
                  builder: (context) => Container(child: Text(message)))),
          orElse: () {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.of(context).size.height * 0.3,
                ),
                InputWidget.email(
                  onChanged: (value) => _controller.onChange(email: value),
                  validator: (value) =>
                      isEmail(value!) ? null : 'Digite um e-mail válido!',
                ),
                const SizedBox(height: 18),
                InputWidget.password(
                  onChanged: (value) => _controller.onChange(password: value),
                  validator: (value) =>
                      value!.length >= 6 ? null : 'Digite uma senha mais forte',
                ),
                const SizedBox(height: 24),
                AnimatedBuilder(
                    animation: _controller,
                    builder: (_, __) {
                      return _controller.state.when(
                        loading: () => const CircularProgressIndicator(),
                        orElse: () => Column(
                          children: [
                            ButtonWidget.login(
                              onPressed: () {
                                _controller.login();
                              },
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            ButtonWidget.create(
                              onPressed: () {
                                Navigator.pushNamed(context, '/createAccount');
                              },
                            )
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
