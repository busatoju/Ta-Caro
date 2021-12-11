import 'package:flutter/material.dart';
import 'package:ta_caro/shared/theme/theme_app.dart';

class BottomNavBarWidget extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onChanged;
  const BottomNavBarWidget(
      {Key? key, required this.currentIndex, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 26, right: 26, bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildItem(
                enabled: 0 == currentIndex,
                icon: Icons.home,
                onTap: () => onChanged(0)),
            buildItem(
                enabled: false, icon: Icons.add, onTap: () => onChanged(2)),
            buildItem(
                enabled: 1 == currentIndex,
                icon: Icons.person,
                onTap: () => onChanged(1)),
          ],
        ),
      ),
    );
  }

  Widget buildItem(
      {required bool enabled,
      required IconData icon,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: enabled
              ? ThemeApp.colors.primary
              : ThemeApp.colors.background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon,
            color: enabled
                ? ThemeApp.colors.textEnabled
                : ThemeApp.colors.iconInactive),
      ),
    );
  }
}
