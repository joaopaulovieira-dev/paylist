import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paylist/page/login/widget/menu_widget.dart';

import '../../../../theme/app_theme.dart';

class FormResetSenhaWidget extends StatefulWidget {
  final TextEditingController emailController;
  final bool isLoading;
  final VoidCallback resetPassword;

  const FormResetSenhaWidget({
    super.key,
    required this.emailController,
    required this.isLoading,
    required this.resetPassword,
  });

  @override
  State<FormResetSenhaWidget> createState() => _FormResetSenhaWidgetState();
}

class _FormResetSenhaWidgetState extends State<FormResetSenhaWidget> {
  bool _isLoginFormActive = true;
  String _activeMenuItem = 'Voltar'; // Inicializar com o item 'Voltar'

  void _toggleForm() {
    setState(() {
      _isLoginFormActive = !_isLoginFormActive;
    });
  }

  void _setActiveMenuItem(String item) {
    setState(() {
      _activeMenuItem = item;

      _isLoginFormActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Menu(
          activeItem: _activeMenuItem,
          onItemPressed: (item) {
            if (kDebugMode) {
              print(item);
            } // Exibe o texto do item clicado no console
            _toggleForm();
            _setActiveMenuItem(item);
          },
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              "Esqueceu a senha?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Digite seu e-mail e nós lhe enviaremos um link para redefinir a senha.",
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
        const SizedBox(height: 30),
        TextField(
          controller: widget.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'E-mail',
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
            contentPadding: const EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey[50]!),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey[50]!),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: widget.isLoading ? null : widget.resetPassword,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppTheme.colors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: Center(
              child: widget.isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : const Text("Concluir"),
            ),
          ),
        ),
        const SizedBox(height: 40)
      ],
    );
  }
}
