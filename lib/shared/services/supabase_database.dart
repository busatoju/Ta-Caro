import 'package:supabase/supabase.dart';
import 'package:ta_caro/shared/models/user_model.dart';
import 'package:ta_caro/shared/services/database_services.dart';

class SupabaseDatabase implements IDatabaseServices {
  late final SupabaseClient client;

  SupabaseDatabase() {
    init();
  }

  @override
  Future<UserModel> createAccount(
      {required String email,
      required String password,
      required String name}) async {
    final response = await client.auth.signUp(email, password);
    if (response.error == null) {
      final user = UserModel(email: email, name: name, id: response.user!.id);
      await createUser(user);
      return user;
    } else {
      throw Exception(
          response.error?.message ?? "Não foi possível criar conta");
    }
  }

  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    final response = await client.auth.signIn(email: email, password: password);
    if (response.error == null) {
      final user = await getUser(response.user!.id);
      return user;
    } else {
      throw Exception(
          response.error?.message ?? "Não foi possível acessar a conta");
    }
  }

  @override
  void init() {
    client = SupabaseClient(
      const String.fromEnvironment('supabaseUrl'),
      const String.fromEnvironment('supabaseKey'),
    );
  }

  @override
  Future<UserModel> createUser(UserModel user) async {
    final response = await client.from('users').insert(user.toMap()).execute();
    if (response.data != null) {
      return user;
    } else {
      return throw Exception('Não foi possível criar o usuário');
    }
  }

  @override
  Future<UserModel> getUser(String id) async {
    final response =
        await client.from('users').select().filter('id', 'eq', id).execute();
    if (response.data != null) {
      final user = UserModel.fromMap(response.data[0]);
      return user;
    } else {
      return throw Exception('Não foi possível buscar o usuário');
    }
  }

  @override
  Future<bool> create(
      {required String tableName, required Map<String, dynamic> data}) async {
    final response = await client.from(tableName).insert(data).execute();

    if (response.error != null) {
      throw Exception(response.error!.message);
    } else {
      return true;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getOrders(
      String tableName, String userId) async {
    final response =
        await client.from(tableName).select('*').order('date').execute();
    if (response.error != null) {
      throw Exception('Não foi possível encontrar os dados');
    } else {
      return (response.data as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList();
    }
  }

  @override
  Future<void> deleteOrder(String tableName, String id) async {
    await client.from(tableName).delete().eq('id', id).execute();
  }
}
