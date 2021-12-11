import 'package:flutter/material.dart';
import 'package:ta_caro/modules/feed/feed_controller.dart';
import 'package:ta_caro/modules/feed/feed_repository.dart';
import 'package:ta_caro/shared/models/oder_model.dart';
import 'package:ta_caro/shared/models/user_model.dart';
import 'package:ta_caro/shared/services/database_services.dart';
import 'package:ta_caro/shared/theme/theme_app.dart';
import 'package:ta_caro/shared/widgets/card_chart_widget.dart';
import 'package:ta_caro/shared/widgets/card_tile.dart';
import 'package:ta_caro/shared/widgets/list_tile_widget.dart';

class FeedView extends StatefulWidget {
  const FeedView({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  late final FeedController _controller;

  @override
  void initState() {
    _controller = FeedController(FeedRepository(
      database: IDatabaseServices.instance,
      userId: '',
    ));
    _controller.getOrders();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) => _controller.state.when(
            success: (value) {
              final orders = value as List<OrderModel>;
              final products = _controller.products;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardChartWidget(
                    value: _controller.sumTotal,
                    percent: _controller.calcChart(products),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 26, top: 8, bottom: 8),
                    child: Text(
                      'Preço dos produtos',
                      style: ThemeApp.textStyles.label,
                    ),
                  ),
                  SizedBox(
                    height: 125,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: products.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => CardTile(
                        product: products[index],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 26, top: 8, bottom: 8),
                    child: Text('Suas últimas compras',
                        style: ThemeApp.textStyles.subtitle
                            .copyWith(fontSize: 16)),
                  ),
                  for (var order in orders)
                    ListTileWidget(
                      order: order,
                      onChange: () {},
                      delete: () => _controller.deleteOrders(order.id),
                    ),
                ],
              );
            },
            orElse: () => Container(),
          ),
        ),
      ),
    );
  }
}
