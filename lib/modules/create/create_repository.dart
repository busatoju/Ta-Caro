import 'package:ta_caro/shared/services/database_services.dart';

abstract class ICreateRepository {
  Future<bool> create({
    required String name,
    required String price,
    required String date,
    required String userId,
  });
}

class CreateRepository implements ICreateRepository {
  final IDatabaseServices database;

  CreateRepository({
    required this.database,
  });

  @override
  Future<bool> create({
    required String name,
    required String price,
    required String date,
    required String userId,
  }) async {
    final priceSanitize = double.parse(price.replaceAll('R\$', ''));
    final response = await database.create(tableName: 'orders', data: {
      'name': name,
      'price': priceSanitize,
      'date': date,
      'userId': userId
    });
    return response;
  }
}
