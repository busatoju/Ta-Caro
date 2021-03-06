import 'package:flutter/material.dart';
import 'package:ta_caro/modules/login/repositories/login_repository.dart';
import 'package:ta_caro/shared/services/database_services.dart';
import 'package:ta_caro/shared/theme/theme_app.dart';
import 'package:ta_caro/shared/widgets/button_widget.dart';
import 'package:ta_caro/shared/widgets/input_widget.dart';
import 'package:ta_caro/shared/widgets/text_button_widget.dart';
import 'package:validators/validators.dart';
import 'create_account_controller.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({Key? key}) : super(key: key);

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  late final CreateAccountController _controller;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _controller = CreateAccountController(
        LoginRepository(databse: IDatabaseServices.instance));
    _controller.addListener(() {
      _controller.state.when(
          success: (value) => Navigator.pop(context),
          error: (message, _) => scaffoldKey.currentState!.showBottomSheet(
                (context) => BottomSheet(
                  onClosing: () {},
                  builder: (context) => SizedBox(
                    child: Text(message),
                  ),
                ),
              ),
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
          padding: const EdgeInsets.all(24),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Criar conta',
                  style: ThemeApp.textStyles.title,
                ),
                const SizedBox(height: 10),
                Text(
                  'Mantenha seus gastos em dia',
                  style: ThemeApp.textStyles.subtitle,
                ),
                const SizedBox(height: 30),
                InputWidget.name(
                  onChanged: (value) => _controller.onChange(name: value),
                  validator: (value) =>
                      value!.length >= 6 ? null : 'Digite seu nome completo',
                ),
                const SizedBox(height: 18),
                InputWidget.email(
                  validator: (value) =>
                      isEmail(value!) ? null : 'Digite um e-mail v??lido!',
                  onChanged: (value) => _controller.onChange(email: value),
                ),
                const SizedBox(height: 18),
                InputWidget.password(
                  validator: (value) =>
                      value!.length >= 6 ? null : 'Digite uma senha mais forte',
                  onChanged: (value) => _controller.onChange(password: value),
                ),
                const SizedBox(height: 24),
                AnimatedBuilder(
                    animation: _controller,
                    builder: (_, __) {
                      return _controller.state.when(
                        loading: () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                          ],
                        ),
                        orElse: () => ButtonWidget.createAccount(
                            onPressed: () => _controller.createAccount()),
                      );
                    }),
                const SizedBox(height: 18),
                TextButtonWidget(
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed('/login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
