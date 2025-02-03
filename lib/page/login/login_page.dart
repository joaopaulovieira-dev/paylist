// ignore_for_file: library_prefixes, library_private_types_in_public_api, use_build_context_synchronously, unused_field

import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import 'widget/body_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.background,
      body: Center(
        child: SingleChildScrollView(
          child: const BodyWidget(),
        ),
      ),
    );
  }
}
