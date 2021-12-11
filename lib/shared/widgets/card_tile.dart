import 'package:flutter/material.dart';
import 'package:ta_caro/shared/models/product_model.dart';
import 'package:ta_caro/shared/theme/theme_app.dart';

class CardTile extends StatelessWidget {
  final ProductModel product;

  const CardTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 245,
      margin: const EdgeInsets.only(top: 8, bottom: 8, left: 26),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ThemeApp.colors.textEnabled,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: ThemeApp.colors.background,
              radius: 30,
              child: product.lastPrice == 0
                  ? Icon(
                      Icons.shopping_cart,
                      color: ThemeApp.colors.iconInactive,
                    )
                  : product.currentPrice < product.lastPrice
                      ? Icon(Icons.thumb_up, color: ThemeApp.colors.primary)
                      : Icon(
                          Icons.thumb_down,
                          color: ThemeApp.colors.badColor,
                        ),
            ),
            title: Text(
              product.name,
              style: ThemeApp.textStyles.titleListTile,
            ),
            subtitle: product.lastPrice == 0
                ? null
                : Text(
                    'Estava R\$ ${product.lastPrice}',
                    style: ThemeApp.textStyles.subtitleListTile,
                  ),
          ),
          Text.rich(
            TextSpan(
              text: 'Agora\n',
              style: ThemeApp.textStyles.subtitleListTile,
              children: [
                TextSpan(
                  text: 'R\$ ${product.currentPrice}',
                  style: ThemeApp.textStyles.titleListTile,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
