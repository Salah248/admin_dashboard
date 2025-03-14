import 'package:admin_dashboard/di.dart';
import 'package:admin_dashboard/presentaion/auth/Login/login_view.dart';
import 'package:flutter/material.dart';

void main() {
  setUpDi(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Our Market Admin',
      theme: ThemeData(useMaterial3: true),
      home:  const LoginView(),
    );
  }
}
