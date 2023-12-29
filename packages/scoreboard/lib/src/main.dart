import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'functions/auth_user_helper.dart';
import 'globals/colors.dart';
import 'routes.dart';
import 'screens/home.dart';
import 'stores/common_store.dart';
import 'stores/gc_store.dart';
import 'stores/kriti_store.dart';
import 'stores/manthan_store.dart';
import 'stores/sahyog_store.dart';
import 'stores/spardha_store.dart';
import 'widgets/ui/err_reload.dart';
import 'widgets/common/home_app_bar.dart';
import 'widgets/ui/shimmer.dart';
import 'widgets/common/top_bar.dart';
import 'widgets/filters/spardha_filter_bar.dart';

class GCScoreBoard extends StatefulWidget {
  final Map<String, String> userInfo;
  const GCScoreBoard({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<GCScoreBoard> createState() => _GCScoreBoardState();
}

class _GCScoreBoardState extends State<GCScoreBoard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthUserHelpers.setAccessToken('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NGM3NWM4YWE2ZDE3ZWE0NTYyM2M5ODIiLCJpYXQiOjE3MDM4NDQzNjcsImV4cCI6MTcwNDcwODM2N30.cYc0JY1w8dHYuKu_IzwYK29auKn3zdvpBOc5Coeyygw').then((value){
      AuthUserHelpers.setRefreshToken('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NGM3NWM4YWE2ZDE3ZWE0NTYyM2M5ODIiLCJpYXQiOjE3MDM4NDQzNjcsImV4cCI6MTcwNjQzNjM2N30.iRj7Tq_AjwQomH0gLohbLQgPvFPkn89krpXioPgBfOw').then((value) {
        print('****************************Tokens set*************************');
      });
    });
  }
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
          Provider<SahyogStore>(
            create: (_) => SahyogStore(),

          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Builder(builder: (buildContext) {
            reloadCallback() {
              // reload page
              setState(() {});
            }

            return FutureBuilder(
              future:
                  AuthUserHelpers.saveUserData(widget.userInfo, buildContext),
              builder: (futureContext, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Scaffold(
                    backgroundColor: Themes.backgroundColor,
                    appBar: const PreferredSize(
                        preferredSize: Size.fromHeight(56),
                        child: AppBarHomeComponent()),
                    body: Center(
                      child: Column(
                        children: [
                          Shimmer.fromColors(
                            baseColor: Themes.kShimmerBaseColor,
                            highlightColor: Themes.kShimmerHighlightColor,
                            child: const IgnorePointer(child: TopBar()),
                          ),
                          Shimmer.fromColors(
                            baseColor: Themes.kShimmerBaseColor,
                            highlightColor: Themes.kShimmerHighlightColor,
                            child: const IgnorePointer(child: SpardhaFilterBar()),
                          ),
                          Expanded(
                              child: ShowShimmer(
                            height: 400,
                            width: MediaQuery.of(context).size.width,
                          )),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Scaffold(
                      backgroundColor: Themes.backgroundColor,
                      body: Column(children: [
                        ErrorReloadPage(apiFunction: reloadCallback)
                      ]));
                }
                return const ScoreBoardHome();
              },
            );
          }),
          routes: routes,
        ));
  }
}
