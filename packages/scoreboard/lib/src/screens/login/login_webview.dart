import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:scoreboard/src/globals/enums.dart';
import 'package:scoreboard/src/services/api.dart';
import 'package:scoreboard/src/stores/common_store.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../functions/snackbar.dart';

class LoginWebView extends StatefulWidget {
  const LoginWebView({Key? key}) : super(key: key);

  @override
  State<LoginWebView> createState() => _LoginWebViewState();
}

class _LoginWebViewState extends State<LoginWebView> {
  Completer<WebViewController> controllerCompleter =
      Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => showSnackBar(context, "You need to login to continue"));
  }

  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    return Observer(builder: (context) {
      return WebView(
        initialUrl: "https://swc.iitg.ac.in/onestopapi/v2/auth/microsoft",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          controllerCompleter.complete(controller);
        },
        onPageFinished: (url) async {
          if (url.startsWith(
              "https://swc.iitg.ac.in/onestopapi/v2/auth/microsoft/redirect?code")) {
            WebViewController controller = await controllerCompleter.future;
            var userInfoString = await controller.runJavascriptReturningResult(
                "document.querySelector('#userInfo').innerText");
            List<String> values = userInfoString.replaceAll('"', '').split("/");
            await CookieManager().clearCookies();
            // print(values);
            // print(await AuthUserHelpers.getUserEmail());
            if (values[0].toLowerCase().contains("error")) {
              if (!mounted) return;

              showSnackBar(context, "Some Error occurred");
            } else {
              await APIService(context).generateTokens(commonStore);
              if (!commonStore.isAdmin) {
                if (!mounted) return;

                showSnackBar(context, "You are not authorized admin");
              } else {
                commonStore.setViewType(ViewType.admin);
              }
            }
            if (!mounted) return;

            Navigator.pop(context, true); // token may be generated
          }
        },
      );
    });
  }
}
