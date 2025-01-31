// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, unused_field

import 'package:flutter/material.dart';
import 'package:paylist/page/login/widget/form_login_widget.dart';
import 'package:paylist/page/login/widget/form_reset_senha_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../theme/app_theme.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  _BodyWidget createState() => _BodyWidget();
}

class _BodyWidget extends State<BodyWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoginFormActive = true;
  bool _isRecuperacaoSenhaFormActive = false; // Adicione este booleano

  bool _isLoading = false;
  String _activeMenuItem = 'Entrar'; // Inicializar com o item 'Entrar'

  void _toggleForm() {
    setState(() {
      _isLoginFormActive = !_isLoginFormActive;
      _isRecuperacaoSenhaFormActive = false;
    });
  }

  void _setActiveMenuItem(String item) {
    setState(
      () {
        _activeMenuItem = item;
        if (item == 'Recuperar Senha') {
          _isRecuperacaoSenhaFormActive = true;
          _isLoginFormActive = false;
        } else if (item == 'Voltar') {
          _isLoginFormActive = false;
          _isRecuperacaoSenhaFormActive = false;
        } else {
          _isLoginFormActive = true;
          _isRecuperacaoSenhaFormActive = false;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            ResponsiveVisibility(
              visible: false,
              visibleConditions: [Condition.equals(name: DESKTOP)],
              child: SizedBox(
                width: 400,
                child: _isRecuperacaoSenhaFormActive
                    ? FormResetSenhaWidget(
                        emailController: _emailController,
                        isLoading: _isLoading,
                        resetPassword: _resetPassword,
                      )
                    : FormLoginWidget(
                        emailController: _emailController,
                        passwordController: _passwordController,
                        isLoading: _isLoading,
                        login: _login,
                        context: context,
                        toggleForm: _toggleForm,
                        setActiveMenuItem: _setActiveMenuItem,
                      ),
              ),
            ),
            ResponsiveVisibility(
              visible: false,
              visibleConditions: [Condition.smallerThan(name: DESKTOP)],
              child: Container(
                child: _isRecuperacaoSenhaFormActive
                    ? FormResetSenhaWidget(
                        emailController: _emailController,
                        isLoading: _isLoading,
                        resetPassword: _resetPassword,
                      )
                    : FormLoginWidget(
                        emailController: _emailController,
                        passwordController: _passwordController,
                        isLoading: _isLoading,
                        login: _login,
                        context: context,
                        toggleForm: _toggleForm,
                        setActiveMenuItem: _setActiveMenuItem,
                      ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      // Exibir mensagem de erro caso os campos de email ou senha estejam vazios
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: const Text('Por favor, preencha todos os campos.',
                style: TextStyle(color: Colors.black)),
            backgroundColor: AppTheme.colors.primary),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Fazer login com Firebase Auth
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Navegar para a próxima tela após o login bem-sucedido
      Navigator.pushReplacementNamed(
          context, '/verificar_perfil'); // Tela de Home
    } on FirebaseAuthException catch (e) {
      // Lidar com exceções de FirebaseAuth, como usuário não encontrado, senha incorreta, etc.
      String errorMessage = _mapFirebaseAuthErrorCode(e.code);

      // Exibir mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text(errorMessage, style: const TextStyle(color: Colors.black)),
            backgroundColor: AppTheme.colors.primary),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _mapFirebaseAuthErrorCode(String code) {
    switch (code) {
      case 'user-not-found':
        return 'Usuário não encontrado.';
      case 'wrong-password':
        return 'Senha incorreta.';
      case 'invalid-email':
        return 'E-mail inválido.';
      case 'user-disabled':
        return 'Usuário desabilitado.';
      case 'operation-not-allowed':
        return 'Operação não permitida.';
      case 'network-request-failed':
        return 'Falha na conexão. Verifique sua conexão com a internet.';
      default:
        return 'Ocorreu um erro durante o login. Por favor, tente novamente mais tarde.';
    }
  }

// Função de reset de senha
  void _resetPassword() {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: const Text('Por favor, insira seu e-mail.',
                style: TextStyle(color: Colors.black)),
            backgroundColor: AppTheme.colors.primary),
      );
      return;
    }

    FirebaseAuth.instance
        .sendPasswordResetEmail(
      email: _emailController.text,
    )
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: const Text(
                'Um e-mail foi enviado para redefinir sua senha.',
                style: TextStyle(color: Colors.black)),
            backgroundColor: AppTheme.colors.primary),
      );
    }).catchError(
      (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Erro ao enviar e-mail de redefinição de senha: $e',
                  style: const TextStyle(color: Colors.black)),
              backgroundColor: AppTheme.colors.primary),
        );
      },
    );
  }
}
