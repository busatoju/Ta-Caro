import 'package:ta_caro/shared/models/oder_model.dart';
import 'package:ta_caro/shared/services/database_services.dart';

abstract class IFeedRepository {
  Future<List<OrderModel>> getOrders();
  Future<void> deleteOrder(String id);
}

class FeedRepository implements IFeedRepository {
  final IDatabaseServices database;
  final String userId;

  FeedRepository({
    required this.database,
    required this.userId,
  });

  @override
  Future<List<OrderModel>> getOrders() async {
    final response = await database.getOrders('orders', userId);
    return response.map((e) => OrderModel.fromMap(e)).toList();
  }

  @override
  Future<void> deleteOrder(String id) async {
    await database.deleteOrder('orders', id);
  }
}
