import 'package:flutter/cupertino.dart';
import 'package:ta_caro/modules/create/create_repository.dart';
import 'package:ta_caro/shared/utils/state.dart';

class CreateController extends ChangeNotifier {
  final ICreateRepository repository;

  IState state = IState.empty();
  final formKey = GlobalKey<FormState>();
  String _name = '';
  String _price = '';
  String _date = '';
  

  CreateController(this.repository);

  void onChange({String? name, String? price, String? date}) {
    _name = name ?? _name;
    _price = price ?? _price;
    _date = date ?? _date;
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

  Future<void> create({required String userId}) async {
    if (validate()) {
      try {
        update(IState.loading());
        final response = await repository.create(
            name: _name, price: _price, date: _date, userId: userId);
        if (response) {
          update(IState.success<bool>(response));
        } else {
          throw Exception('Não foi possível cadastrar');
        }
      } catch (e) {
        update(IState.error(e.toString()));
      }
    }
  }
}
