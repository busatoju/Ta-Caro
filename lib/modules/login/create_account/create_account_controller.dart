import 'package:flutter/material.dart';
import 'package:ta_caro/modules/login/repositories/login_repository.dart';
import 'package:ta_caro/shared/models/user_model.dart';
import 'package:ta_caro/shared/utils/state.dart';

class CreateAccountController extends ChangeNotifier {
  final LoginRepository repository;

  IState state = IState.empty();
  String? _name = '';
  String? _email = '';
  String? _password = '';

  final formKey = GlobalKey<FormState>();

  CreateAccountController(this.repository);

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
        final response = await repository.createAccount(
            email: _email!, password: _password!, name: _name!);
        update(IState.success<UserModel>(response));
      } catch (e) {
        update(IState.error(
          e.toString(),
        ));
      }
    }
  }
}
