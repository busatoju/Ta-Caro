import 'package:ta_caro/shared/models/user_model.dart';
import 'package:ta_caro/shared/services/supabase_database.dart';

abstract class IDatabaseServices {
  static final IDatabaseServices instance = SupabaseDatabase();

  void init();
  Future<UserModel> getUser(String id);

  Future<UserModel> createUser(UserModel user);

  Future<UserModel> login({required String email, required String password});

  Future<UserModel> createAccount(
      {required String email, required String password, required String name});

  Future<bool> create(
      {required String tableName, required Map<String, dynamic> data});

  Future<List<Map<String, dynamic>>> getOrders(String tableName, String userId);
  Future<void> deleteOrder(String tableName, String id);
}
