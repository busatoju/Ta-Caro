import 'package:ta_caro/modules/login/repositories/i_login_repository.dart';
import 'package:ta_caro/shared/models/user_model.dart';
import 'package:ta_caro/shared/services/database_services.dart';

class LoginRepository implements ILoginRepository {
  final IDatabaseServices databse;

  LoginRepository({
    required this.databse,
  });

  @override
  Future<UserModel> createAccount(
      {required String name,
      required String email,
      required String password}) async {
    final response = await databse.createAccount(
      email: email,
      password: password,
      name: name,
    );
    return response;
  }

  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    final response = await databse.login(
      email: email,
      password: password,
    );
    return response;
  }
}
