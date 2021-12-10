import 'package:flutter/material.dart';
import 'package:ta_caro/shared/utils/state.dart';

class CreateAccountController extends ChangeNotifier {
  IState state = IState.empty();
  String? _name = '';
  String? _email = '';
  String? _password = '';

  final formKey = GlobalKey<FormState>();

  void onChange({String? name, String? email, String? password}) {
    _name = name ?? _name;
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

  Future<void> createAccount() async {
    if (validate()) {
      try {
        update(IState.loading());
        await Future.delayed(const Duration(seconds: 3));
        update(IState.success<String>('Deu certo'));
      } catch (e) {
        update(IState.error(
            message:
                'Não foi possível criar a conta, tente novamente mais tarde'));
      }
    }
  }
}
