import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hasnan_latihan2pertemuan4/auth/auth_page.dart';
import 'package:hasnan_latihan2pertemuan4/firebase_options.dart';
// ignore: unused_import
import 'package:intl/date_symbol_data_file.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: AuthPage(),
      debugShowCheckedModeBanner: false,
    ); // MaterialApp
  }
}
