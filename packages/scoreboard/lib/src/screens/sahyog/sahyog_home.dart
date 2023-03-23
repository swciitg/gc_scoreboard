import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../globals/colors.dart';
import '../../globals/enums.dart';
import '../../stores/common_store.dart';
import '../../widgets/common/bottom_navigation_bar.dart';
import '../../widgets/common/home_app_bar.dart';
import '../../widgets/ui/restricted_page.dart';
import '../../widgets/schedule_page/add_button.dart';
import 'forms/add_sahyog_event_form.dart';
import 'sahyog_results_page.dart';
import 'sahyog_schedule_page.dart';
import 'sahyog_standings_page.dart';

class SahyogHome extends StatefulWidget {
  const SahyogHome({Key? key}) : super(key: key);

  @override
  State<SahyogHome> createState() => _SahyogHomeState();
}

class _SahyogHomeState extends State<SahyogHome> {
  Map<Pages, Widget> tabs = {
    Pages.schedule: const SahyogSchedulePage(),
    Pages.standings: const SahyogStandingsPage(),
    Pages.results: const SahyogResultsPage(),
  };
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    return Observer(builder: (context) {
      return Scaffold(
        backgroundColor: Themes.backgroundColor,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(56), child: AppBarHomeComponent()),
        body: commonStore.viewType == ViewType.user
            ? tabs[commonStore.page]
            : (commonStore.isSahyogAdmin
            ? tabs[commonStore.page]
            : const RestrictedPage()),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
          commonStore.viewType == ViewType.admin &&
      commonStore.isSahyogAdmin &&
      commonStore.page == Pages.schedule
            ? GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SahyogEventForm()));
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


