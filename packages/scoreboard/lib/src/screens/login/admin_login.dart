
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:scoreboard/src/screens/login/login_webview.dart';
import 'package:scoreboard/src/widgets/common/home_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginView extends StatefulWidget {
  static const id = '/admin/login';
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      appBar: PreferredSize(preferredSize:  Size.fromHeight(56), child: AppBarHomeComponent()),
      body: LoginWebView(),
    );
  }
}
