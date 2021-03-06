import 'package:flutter/material.dart';
import 'package:ta_caro/modules/login/repositories/login_repository.dart';
import 'package:ta_caro/shared/models/user_model.dart';
import 'package:ta_caro/shared/utils/state.dart';

class LoginController extends ChangeNotifier {
  final LoginRepository repository;

  IState state = IState.empty();
  final formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  LoginController(this.repository);

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
        final response = await repository.login(email: _email, password: _password);
        update(IState.success<UserModel>(response));
      } catch (e) {
       update(IState.error(
          e.toString(),
        ));
      }
    }
  }
}
//TODO: Colocar o validator dentro do controller.