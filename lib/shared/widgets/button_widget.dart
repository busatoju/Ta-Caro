import 'package:flutter/material.dart';
import 'package:ta_caro/shared/theme/theme_app.dart';

enum ButtonType { fill, outline }

class ButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonType buttonType;

  const ButtonWidget.login({
    Key? key,
    this.label = 'ENTRAR',
    required this.onPressed,
    this.buttonType = ButtonType.fill,
  }) : super(key: key);

  const ButtonWidget.create({
    Key? key,
    this.label = 'CRIAR CONTA',
    required this.onPressed,
    this.buttonType = ButtonType.outline,
  }) : super(key: key);

  const ButtonWidget.createAccount({
    Key? key,
    this.label = 'CRIAR CONTA',
    required this.onPressed,
    this.buttonType = ButtonType.fill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: buttonType == ButtonType.fill
              ? ThemeApp.colors.primary
              : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
                color: buttonType == ButtonType.outline
                    ? ThemeApp.colors.border
                    : ThemeApp.colors.primary,
                width: 2),
          ),
        ),
        child: Text(
          label,
          style: buttonType == ButtonType.fill
              ? ThemeApp.textStyles.buttonBackgroundColor
              : ThemeApp.textStyles.buttonBoldTextColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
