import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/globals/enums.dart';
import 'package:scoreboard/src/services/api.dart';
import 'package:scoreboard/src/stores/common_store.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:scoreboard/src/functions/snackbar.dart';
class LoginWebView extends StatefulWidget {
  const LoginWebView({Key? key}) : super(key: key);

  @override
  State<LoginWebView> createState() => _LoginWebViewState();
}

class _LoginWebViewState extends State<LoginWebView> {
  Completer<WebViewController> controllerCompleter = Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => showSnackBar(context, "You need to login to continue"));
  }

  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    bool redirectPageLoaded = false;
    return Observer(
      builder: (context) {
        return WebView(
          initialUrl: "https://swc.iitg.ac.in/onestopapi/v2/auth/microsoft",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (_controller){
            controllerCompleter.complete(_controller);
          },
          onPageFinished: (url) async {
            if(redirectPageLoaded) return;
            if (url.startsWith(
                "https://swc.iitg.ac.in/onestopapi/v2/auth/microsoft/redirect?code")) {
              redirectPageLoaded=true;
              WebViewController controller = await controllerCompleter.future;
              var userInfoString = await controller.runJavascriptReturningResult(
                  "document.querySelector('#userInfo').innerText");
              List<String> values = userInfoString.replaceAll('"', '').split("/");
              await controller.clearCache();
              await CookieManager().clearCookies();
              if (!values[0].toLowerCase().contains("error")) {
                await APIService(context).generateTokens();
                commonStore.setViewType(ViewType.admin);
              }
              Navigator.pop(context);
            }
          },
        );
      }
    );
  }
}
