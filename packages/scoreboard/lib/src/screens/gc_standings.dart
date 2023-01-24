import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../globals/styles.dart';
import '../widgets/common/err_reload.dart';
import '../widgets/common/shimmer.dart';
import '../functions/filter_men_women.dart';
import '../globals/colors.dart';
import '../services/api.dart';
import '../stores/gc_store.dart';
import '../widgets/common/bottom_navigation_bar.dart';
import '../widgets/common/home_app_bar.dart';
import '../widgets/standings_page/standingboard.dart';

class GCStandingsPage extends StatefulWidget {
  const GCStandingsPage({super.key});

  @override
  State<GCStandingsPage> createState() => _GCStandingsPageState();
}

class _GCStandingsPageState extends State<GCStandingsPage> {
  final _itemsCategory = ['Men', 'Women'];

  @override
  Widget build(BuildContext context) {
    var gcStore = context.read<GCStore>();

    reloadCallback() {
      // reload page
      setState(() {});
    }

    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(56), child: AppBarHomeComponent()),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Column(
            children: [
              SizedBox(
                height: 56,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: Container(
                    height: 56,
                    decoration: boxDecoration,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                      child: PopupMenuButton(
                        constraints: const BoxConstraints(maxHeight: 300),
                        position: PopupMenuPosition.under,
                        color: Themes.cardColor1,
                        onSelected: (String item) {
                          gcStore.changeSelectedCategory(item);
                          setState(() {});
                        },
                        itemBuilder: (BuildContext context) => _itemsCategory
                            .map((item) => PopupMenuItem<String>(
                                  value: item,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        'General Championship [$item]',
                                        style: popUpItemStyle,
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                        child: Container(
                          height: 56,
                          decoration: boxDecoration,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 12,
                                      child: Text('Category',
                                          style: popUpHeadingStyle),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      height: 18,
                                      child: Text(
                                          'General Championship [${gcStore.selectedCategory.categoryName}]',
                                          style: popUpItemStyle),
                                    )
                                  ],
                                ),
                                popUpIcon,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SvgPicture.asset(
                        "packages/scoreboard/assets/trophy.svg",
                      ),
                    ),
                    Text(
                      'GC [${gcStore.selectedCategory.categoryName}] Standings',
                      style: standingsHeadingStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Divider(
                thickness: 0.7,
                color: Themes.dividerColor1,
                height: 0,
                indent: 8,
                endIndent: 8,
              ),
              FutureBuilder<List<dynamic>>(
                  future: APIService(context).getGCStandings(),
                  builder: (context, snapshot) {
                    print("in call");
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: ShowShimmer(
                              height: 400,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return Observer(builder: (context) {
                        return Expanded(
                            child: StandingBoard(
                          hostelStandings: filterGCStandings(
                              gcStore.selectedCategory, snapshot.data!),
                        ));
                      });
                    }
                    return ErrorReloadPage(apiFunction: reloadCallback);
                  })
            ],
          )),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
