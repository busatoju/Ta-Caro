import 'package:flutter/material.dart';
import 'package:ta_caro/shared/models/oder_model.dart';
import 'package:ta_caro/shared/models/product_model.dart';
import 'package:ta_caro/shared/utils/state.dart';
import 'feed_repository.dart';

class FeedController extends ChangeNotifier {
  final IFeedRepository repository;

  IState state = IState.empty();

  FeedController(this.repository);

  void update(IState state) {
    this.state = state;
    notifyListeners();
  }

  List<OrderModel> get orders =>
      state.when(success: (value) => value, orElse: () => []);

  double get sumTotal {
    var sum = 0.0;
    for (var order in orders) {
      sum += order.price;
    }

    return sum;
  }

  Future<void> getOrders() async {
    try {
      update(IState.loading());
      final response = await repository.getOrders();

      update(IState.success<List<OrderModel>>(response));
    } catch (e) {
      update(IState.error(e.toString()));
    }
  }

  double calcChart(List<ProductModel> products) {
    var up = 0.0;
    var down = 0.0;

    for (var item in products) {
      if (item.currentPrice < item.lastPrice) {
        up += 1;
      } else {
        down += 1;
      }
    }
    final result = down / up;
    if (result > 1) {
      return 1;
    } else {
      return result;
    }
  }

  List<ProductModel> get products {
    final products = <ProductModel>[];
    for (var item in orders) {
      final product =
          ProductModel(name: item.name, lastPrice: 0, currentPrice: item.price);
      final index =
          products.indexWhere((element) => element.name == product.name);
      if (index != -1) {
        final currentProduct = products[index];
        products[index] = currentProduct.copyWith(lastPrice: item.price);
      } else {
        products.add(product);
      }
    }
    return products;
  }

  Future<void> deleteOrders(String id) async {
    await repository.deleteOrder(id);
  }
}
