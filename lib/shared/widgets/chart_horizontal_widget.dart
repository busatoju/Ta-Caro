import 'package:flutter/material.dart';
import 'package:ta_caro/shared/theme/theme_app.dart';

class ChartHorizontal extends StatelessWidget {
  final double percent;
  const ChartHorizontal({Key? key, required this.percent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            ThemeApp.colors.badColor,
            ThemeApp.colors.primary,
          ],
          stops: [percent, 0.0],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (percent > 0 && percent <= 1)
              Text(
                "${(percent * 100).ceil()}%",
                style: ThemeApp.textStyles.chart,
              ),
            if ((1 - percent) > 0)
              Text(
                "${((1 - percent) * 100).ceil()}%",
                style: ThemeApp.textStyles.chart,
              )
          ],
        ),
      ),
    );
  }
}
