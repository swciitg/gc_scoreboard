import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'functions/auth_user_helper.dart';
import 'routes.dart';
import 'screens/home.dart';
import 'screens/splash.dart';
import 'stores/common_store.dart';
import 'stores/gc_store.dart';
import 'stores/kriti_store.dart';
import 'stores/manthan_store.dart';
import 'stores/spardha_store.dart';
import 'widgets/common/err_reload.dart';

class GCScoreBoard extends StatefulWidget {
  Map<String, String> userInfo;
  GCScoreBoard({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<GCScoreBoard> createState() => _GCScoreBoardState();
}

class _GCScoreBoardState extends State<GCScoreBoard> {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        Provider<CommonStore>(
          create: (_) => CommonStore(),
        ),
        Provider<GCStore>(
          create: (_) => GCStore(),
        ),
        Provider<SpardhaStore>(
          create: (_) => SpardhaStore(),
        ),
        Provider<KritiStore>(
          create: (_) => KritiStore(),
        ),
        Provider<ManthanStore>(
          create: (_) => ManthanStore(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(
            builder: (buildContext){
              reloadCallback(){ // reload page
                setState(() {});
              }
              return FutureBuilder(
                future: AuthUserHelpers.saveUserData(widget.userInfo, buildContext),
                builder: (futureContext, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  else if(snapshot.hasError){
                    print("snapshot has error");
                    return Scaffold(body: ErrorReloadPage(apiFunction: reloadCallback),);
                  }
                  return const ScoreBoardHome();
                },
              );
            }),
        routes: routes,
      )
    );
  }
}
