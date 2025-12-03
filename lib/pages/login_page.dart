import 'package:flutter/material.dart';
import '../widgets/app_header.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

void _placeholder() {}
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppHeader(
              onLogoTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },