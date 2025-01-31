import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';

class FormLoginWidget extends StatelessWidget {
  final BuildContext context;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final VoidCallback login;
  final VoidCallback toggleForm;
  final void Function(String) setActiveMenuItem;

  const FormLoginWidget({
    super.key,
    required this.context,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    required this.login,
    required this.toggleForm,
    required this.setActiveMenuItem,
  });

  @override
  Widget build(BuildContext context) {
    return _formLogin();
  }

  Widget _formLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Image.asset(
              'assets/images/logo.png',
              width: 70,
              height: 70,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "PayList",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Tenha acesso as melhores ações da Bolsa de Valores.",
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
        TextField(
          controller: emailController,
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
        Column(
          children: [
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                // suffixIcon: const Icon(
                //   Icons.visibility_off_outlined,
                //   color: Colors.grey,
                // ),
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
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
                height:
                    10), // Espaçamento entre o campo de senha e o botão "Esqueci Minha Senha"
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Alinha os elementos à direita
              children: [
                TextButton(
                  //desativar houver
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    toggleForm(); // Chama o método _toggleForm() passado como argumento
                    setActiveMenuItem(
                        'Recuperar Senha'); // Chama o método _setActiveMenuItem() passado como argumento
                  },
                  child: Text(
                    'Esqueci Minha Senha',
                    style: TextStyle(
                      color: AppTheme.colors.primary, // Cor do texto do botão
                      fontWeight: FontWeight.bold, // Estilo do texto do botão
                      fontSize: 12, // Tamanho da fonte do texto do botão
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.colors.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ElevatedButton(
            onPressed: isLoading ? null : login,
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
                child: isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text("Entrar",
                        style: TextStyle(
                          color: Colors.white,
                        )),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
