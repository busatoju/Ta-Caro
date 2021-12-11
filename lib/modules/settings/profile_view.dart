import 'package:flutter/material.dart';
import 'package:ta_caro/shared/models/user_model.dart';
import 'package:ta_caro/shared/theme/theme_app.dart';

class ProfileView extends StatefulWidget {
  final UserModel user;
  const ProfileView({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool _value = true;

  void changeMode(value) {
    _value = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Perfil',
              style: ThemeApp.textStyles.title.copyWith(fontSize: 30),
            ),
            const SizedBox(height: 16),
            buildItem(label: 'Nome de usuário:', text: widget.user.name),
            buildItem(label: 'E-mail:', text: widget.user.email),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ThemeApp.colors.textEnabled),
              child: ListTile(
                onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                title: Text(
                  'Sair da conta',
                  style: ThemeApp.textStyles.titleListTile,
                ),
                trailing: Icon(
                  Icons.logout,
                  color: ThemeApp.colors.iconInactive,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ThemeApp.colors.textEnabled),
              child: SwitchListTile(
                title: const Text('Modo Escuro'),
                subtitle: Text('Em breve'),
                value: _value,
                onChanged: (bool value) => changeMode(value),
              ),
            ),
            const SizedBox(height: 16),
            buildItem(label: 'Versão', text: '0.1')
          ],
        ),
      ),
    );
  }

  Widget buildItem({required String label, required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ThemeApp.colors.textEnabled),
        child: ListTile(
          title: Text(
            label,
            style: ThemeApp.textStyles.subtitleListTile,
          ),
          subtitle: Text(
            text,
            style: ThemeApp.textStyles.titleListTile,
          ),
        ),
      ),
    );
  }
}
