import 'package:flutter/material.dart';
import 'package:ta_caro/shared/theme/theme_app.dart';

class InputWidget extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscure;
  final bool isPassword;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const InputWidget.name({
    Key? key,
    this.label = 'Nome',
    this.hint = 'Informe seu nome',
    this.obscure = false,
    this.isPassword = false,
    required this.validator,
    this.onChanged,
  }) : super(key: key);

  const InputWidget.email({
    Key? key,
    this.label = 'E-mail',
    this.hint = 'Digite seu e-mail',
    this.obscure = false,
    this.isPassword = false,
    required this.validator,
    this.onChanged,
  }) : super(key: key);

  const InputWidget.password({
    Key? key,
    this.label = 'Senha',
    this.hint = 'Digite sua senha',
    this.obscure = true,
    this.isPassword = true,
    required this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: ThemeApp.textStyles.label,
        ),
        const SizedBox(height: 12),
        TextFormField(
          obscureText: obscure,
          validator: (value) {
            if (validator != null) {
              return validator!(value ?? "");
            }
          },
          onChanged: onChanged,
          style: ThemeApp.textStyles.input,
          decoration: InputDecoration(
            suffixIcon: isPassword
                ? obscure == true
                    ? const Icon(Icons.visibility_off_outlined)
                    : const Icon(Icons.visibility_outlined)
                : null,
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: ThemeApp.colors.border,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
