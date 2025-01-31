import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:paylist/core/app_widget.dart';
import 'package:paylist/core/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AppWidget());
}
