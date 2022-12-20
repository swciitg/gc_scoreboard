import 'package:flutter/material.dart';
import 'package:scoreboard/src/globals/helper_variables.dart';
import 'package:scoreboard/src/widgets/app_bar.dart';
class LoginView extends StatefulWidget {
  static const id = '/admin/login';
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, viewType.admin),
      body: Center(child: Text("Admin Login"),),
    );
  }
}
