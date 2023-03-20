import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../globals/colors.dart';
import '../../globals/enums.dart';
import '../../stores/common_store.dart';
import '../../widgets/common/home_app_bar.dart';
import '../../widgets/schedule_page/add_button.dart';
import '../../widgets/common/bottom_navigation_bar.dart';
import '../../widgets/common/restricted_page.dart';
import 'forms/add_event_form.dart';
import 'added_standings.dart';
import 'spardha_results_page.dart';
import 'spardha_schedule_page.dart';
import 'spardha_standings_page.dart';

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
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(56), child: AppBarHomeComponent()),
          body: commonStore.viewType == ViewType.user
              ? tabs[commonStore.page]
              : (commonStore.isSpardhaAdmin
                  ? tabs[commonStore.page]
                  : const RestrictedPage()),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: commonStore.viewType == ViewType.admin &&
                  commonStore.isSpardhaAdmin &&
                  commonStore.page != Pages.results
              ? GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => commonStore.page == Pages.schedule
                            ? const SpardhaEventForm()
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
