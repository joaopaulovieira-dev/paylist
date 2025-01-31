// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

class SupervisoresPage extends StatefulWidget {
  const SupervisoresPage({super.key});

  @override
  _SupervisoresPageState createState() => _SupervisoresPageState();
}

class _SupervisoresPageState extends State<SupervisoresPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supervisores', style: TextStyle(fontSize: 30)),
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: AppTheme.colors.appBar,
        surfaceTintColor: AppTheme.colors.appBar,
      ),
      backgroundColor: AppTheme.colors.white,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Supervisores',
            )
          ],
        ),
      ),
    );
  }
}
