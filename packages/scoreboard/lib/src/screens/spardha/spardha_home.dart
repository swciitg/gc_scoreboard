import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:scoreboard/src/screens/spardha/added_standings.dart';
import '../../globals/colors.dart';
import '../../globals/enums.dart';
import '../../stores/common_store.dart';
import '../../widgets/common/home_app_bar.dart';
import '../../widgets/schedule_page/add_button.dart';
import 'add_event_form.dart';
import '../../widgets/common/bottom_navigation_bar.dart';
import 'results_page.dart';
import 'schedule_page.dart';
import 'standings_page.dart';

class SpardhaHome extends StatefulWidget {
  const SpardhaHome({Key? key}) : super(key: key);

  @override
  State<SpardhaHome> createState() => _SpardhaHomeState();
}

class _SpardhaHomeState extends State<SpardhaHome> {
  @override
  void initState() {
    super.initState();
  }

  Map<Pages, Widget> tabs = {
    Pages.schedule: const SchedulePage(),
    Pages.standings: const StandingsPage(),
    Pages.results: const ResultsPage(),
  };

  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    return Observer(
      builder: (context) {
        return Scaffold(
          backgroundColor: Themes.backgroundColor,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: AppBarHomeComponent(homeViewType: commonStore.viewType)),
          body: tabs[commonStore.page],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: commonStore.viewType == ViewType.admin &&
                  commonStore.page != Pages.results
              ? GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => commonStore.page == Pages.schedule
                            ? const AddEventForm()
                            : const SpardhaAdminStandingsPage()));
                  },
                  child: AddButton(
                    text: commonStore.page == Pages.schedule
                        ? 'Add event'
                        : 'Add/Update standings',
                    width: commonStore.page == Pages.schedule ? 130 : 220,
                  ),
                )
              : Container(),
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}
