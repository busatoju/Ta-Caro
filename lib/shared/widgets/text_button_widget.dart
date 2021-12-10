import 'package:flutter/material.dart';
import 'package:ta_caro/shared/theme/theme_app.dart';

class TextButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const TextButtonWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Já possui uma conta?'),
        TextButton(
          style: TextButton.styleFrom(primary: ThemeApp.colors.primary),
          onPressed: onPressed,
          child: const Text(
            'Faça login',
          ),
        ),
      ],
    );
  }
}
