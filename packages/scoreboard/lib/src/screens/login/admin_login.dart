import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/globals/helper_variables.dart';
import 'package:scoreboard/src/screens/login/login_webview.dart';
import 'package:scoreboard/src/stores/common_store.dart';
import 'package:scoreboard/src/widgets/common/app_bar.dart';
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
    var commonStore = context.read<CommonStore>();
    return Scaffold(
      appBar: PreferredSize(child: AppBarHomeComponent(homeViewType: commonStore.viewType), preferredSize: const Size.fromHeight(56)),
      body: LoginWebView(),
    );
  }
}
