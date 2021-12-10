import 'package:flutter/material.dart';
import 'package:ta_caro/shared/utils/state.dart';

class LoginController extends ChangeNotifier {
  IState state = IState.empty();
  final formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void onChange({String? email, String? password}) {
    _email = email ?? _email;
    _password = password ?? _password;
  }

  bool validate() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void update(IState state) {
    this.state = state;
    notifyListeners();
  }

  Future<void> login() async {
    if (validate()) {
      try {
        update(IState.loading());
        await Future.delayed(const Duration(seconds: 3));
        update(IState.success<String>('Usuário logado'));
      } catch (e) {
        update(
          IState.error(message: 'Não foi possível acessar a conta'),
        );
      }
    }
  }
}
//TODO: Colocar o validator dentro do controller.