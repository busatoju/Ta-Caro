import 'package:flutter/material.dart';
import 'package:ta_caro/modules/create/create_bottom_sheet.dart';
import 'package:ta_caro/shared/models/user_model.dart';
import 'package:ta_caro/shared/theme/theme_app.dart';
import 'package:ta_caro/shared/widgets/bottom_nav_bar_widget.dart';

class HomeView extends StatefulWidget {
  final List<Widget> views;
  final UserModel user;

  const HomeView({
    Key? key,
    required this.views,
    required this.user,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var currentIndex = 0;
  late final List<Widget> views = widget.views;

  void changeIndex(int index) async {
    if (index == 2) {
      await showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          context: context,
          builder: (context) => CreateBottomSheet(
                user: widget.user,
              ));
    } else {
      currentIndex = index;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeApp.colors.background,
      body: Container(
        key: UniqueKey(),
        child: List.from(views)[currentIndex],
      ),
      bottomNavigationBar: BottomNavBarWidget(
          currentIndex: currentIndex, onChanged: changeIndex),
    );
  }
}
