import 'package:flutter/material.dart';
import 'package:ta_caro/shared/models/oder_model.dart';
import 'package:ta_caro/shared/theme/theme_app.dart';

class ListTileWidget extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onChange;
  final VoidCallback delete;
  const ListTileWidget({
    Key? key,
    required this.order,
    required this.onChange,
    required this.delete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ThemeApp.colors.textEnabled,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: ThemeApp.colors.background,
          radius: 25,
          child: Text(
            order.date.split('-').sublist(1).reversed.join('/'),
            style: ThemeApp.textStyles.leading.copyWith(
                color: ThemeApp.colors.title, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          order.name,
          style: ThemeApp.textStyles.titleListTile,
        ),
        subtitle: Text(
          'R\$ ${order.price.toStringAsFixed(2)}',
          style: ThemeApp.textStyles.subtitleListTile,
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: const Text('Editar'),
              onTap: onChange,
            ),
            PopupMenuItem(
              child: const Text('Excluir'),
              onTap: delete,
            ),
          ],
        ),
      ),
    );
  }
}
