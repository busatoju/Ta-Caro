import 'package:flutter/material.dart';
import 'package:ta_caro/shared/theme/theme_app.dart';
import 'package:ta_caro/shared/widgets/chart_horizontal_widget.dart';

class CardChartWidget extends StatelessWidget {
  final double percent;
  final double value;
  const CardChartWidget({
    Key? key,
    required this.value,
    required this.percent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 26, right: 26, top: 26, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ThemeApp.colors.textEnabled,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Gasto mensal',
            style: ThemeApp.textStyles.label,
          ),
          Text.rich(
            TextSpan(
              text: 'R\$ ',
              style: ThemeApp.textStyles.label,
              children: [
                TextSpan(
                  text: value.toStringAsFixed(2).replaceAll('.', ','),
                  style: ThemeApp.textStyles.title.copyWith(fontSize: 26),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ChartHorizontal(
            percent: percent,
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Relação de compras caras e boas compras',
              style: ThemeApp.textStyles.leading,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: ThemeApp.colors.badColor,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              const Text('PAGOU CARO'),
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: ThemeApp.colors.primary,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              const Text('BOAS COMPRAS'),
            ],
          )
        ],
      ),
    );
  }
}
