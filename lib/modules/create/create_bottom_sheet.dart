import 'package:flutter/material.dart';
import 'package:ta_caro/modules/create/create_controller.dart';
import 'package:ta_caro/modules/create/create_repository.dart';
import 'package:ta_caro/shared/models/user_model.dart';
import 'package:ta_caro/shared/services/database_services.dart';
import 'package:ta_caro/shared/widgets/button_widget.dart';
import 'package:ta_caro/shared/widgets/input_widget.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class CreateBottomSheet extends StatefulWidget {
  final UserModel user;
  const CreateBottomSheet({Key? key, required this.user}) : super(key: key);

  @override
  State<CreateBottomSheet> createState() => _CreateBottomSheetState();
}

class _CreateBottomSheetState extends State<CreateBottomSheet> {
  late final CreateController _controller;

  @override
  void initState() {
    _controller = CreateController(
        CreateRepository(database: IDatabaseServices.instance));
    _controller.addListener(() {
      _controller.state.when(
        success: (_) => Navigator.pop(context),
        orElse: () {},
      );
    });

    super.initState();
  }

  @override
  void dispose() {
     _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
      child: SingleChildScrollView(
        child: Form(
          key: _controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputWidget(
                hint: 'Nome do produto',
                label: 'Produto',
                onChanged: (value) => _controller.onChange(name: value),
                keyboard: TextInputType.name,
                validator: (String? value) => value!.isNotEmpty
                    ? null
                    : 'Favor digitar o nome do produto',
              ),
              InputWidget(
                keyboard: TextInputType.number,
                hint: 'Informe o preço',
                label: 'Preço',
                onChanged: (value) => _controller.onChange(price: value),
                validator: (String? value) =>
                    value!.isNotEmpty ? null : 'Favor digitar o valor',
                inputFormatters: [
                  MoneyInputFormatter(leadingSymbol: 'R\$'),
                ],
              ),
              InputWidget(
                keyboard: TextInputType.datetime,
                hint: 'DD/MM/AAAA',
                label: 'Data da compra',
                inputFormatters: [
                  MaskedInputFormatter('00/00/0000'),
                ],
                onChanged: (value) => _controller.onChange(date: value),
                validator: (String? value) =>
                    value!.isNotEmpty ? null : 'Favor digitar uma data',
              ),
              const SizedBox(height: 8),
              AnimatedBuilder(
                animation: _controller,
                builder: (_, __) => _controller.state.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (message, _) => Text(message),
                  orElse: () => ButtonWidget(
                    onPressed: () => _controller.create(userId: widget.user.id),
                    label: 'Adicionar',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
