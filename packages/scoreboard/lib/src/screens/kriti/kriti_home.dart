import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/globals/enums.dart';
import 'package:scoreboard/src/models/kriti_models/kriti_result_model.dart';
import 'package:scoreboard/src/screens/kriti/forms/add_kriti_event_form.dart';
import 'package:scoreboard/src/screens/kriti/kriti_results_page.dart';
import 'package:scoreboard/src/screens/kriti/kriti_schedule_page.dart';
import 'package:scoreboard/src/screens/kriti/kriti_standings_page.dart';
import '../../globals/colors.dart';
import '../../stores/common_store.dart';
import '../../widgets/common/bottom_navigation_bar.dart';
import '../../widgets/common/coming_soon.dart';
import '../../widgets/common/home_app_bar.dart';
import '../../widgets/common/restricted_page.dart';
import '../../widgets/schedule_page/add_button.dart';

class KritiHome extends StatefulWidget {
  const KritiHome({Key? key}) : super(key: key);

  @override
  State<KritiHome> createState() => _KritiHomeState();
}

class _KritiHomeState extends State<KritiHome> {
  Map<Pages, Widget> tabs = {
    Pages.schedule: const KritiSchedulePage(),
    Pages.standings: const KritiStandingsPage(),
    Pages.results: const KritiResultsPage(),
  };
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    print(commonStore.isKritiAdmin);
    return Observer(builder: (context) {
      return Scaffold(
        backgroundColor: Themes.backgroundColor,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(56), child: AppBarHomeComponent()),
        body: commonStore.viewType == ViewType.user
            ? tabs[commonStore.page]
            : (commonStore.isKritiAdmin
                ? tabs[commonStore.page]
                : const RestrictedPage()),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,


        floatingActionButton: commonStore.viewType == ViewType.admin &&
            commonStore.isKritiAdmin &&
            commonStore.page == Pages.schedule
            ? GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddKritiEventForm()));
          },
          child: const AddButton(
            text: 'Add event',

            width: 130,
          ),
        )
            : Container(),
        bottomNavigationBar: const BottomNavBar(),
      );
    });
  }
}
