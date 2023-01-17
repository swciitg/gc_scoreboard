import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/widgets/common/filter_bar.dart';
import 'package:scoreboard/src/widgets/common/home_app_bar.dart';
import 'package:scoreboard/src/widgets/common/shimmer.dart';
import 'package:scoreboard/src/widgets/common/top_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'functions/auth_user_helper.dart';
import 'globals/colors.dart';
import 'routes.dart';
import 'screens/home.dart';
import 'stores/common_store.dart';
import 'stores/gc_store.dart';
import 'stores/kriti_store.dart';
import 'stores/manthan_store.dart';
import 'stores/spardha_store.dart';
import 'widgets/common/err_reload.dart';

class GCScoreBoard extends StatefulWidget {
  final Map<String, String> userInfo;
  const GCScoreBoard({Key? key, required this.userInfo}) : super(key: key);

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
                            child: const IgnorePointer(child: FilterBar()),
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
