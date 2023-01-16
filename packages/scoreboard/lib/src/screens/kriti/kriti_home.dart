import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/globals/colors.dart';

import 'package:scoreboard/src/widgets/common/coming_soon.dart';
import 'package:scoreboard/src/widgets/common/restricted_page.dart';
import 'package:scoreboard/src/stores/common_store.dart';
import '../../widgets/common/bottom_navigation_bar.dart';
import '../../widgets/common/home_app_bar.dart';

class KritiHome extends StatefulWidget {
  const KritiHome({Key? key}) : super(key: key);

  @override
  State<KritiHome> createState() => _KritiHomeState();
}

class _KritiHomeState extends State<KritiHome> {
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    print(commonStore.isKritiAdmin);
    return Observer(
      builder: (context) {
        return Scaffold(
          backgroundColor: Themes.backgroundColor,
          appBar: const PreferredSize(
              preferredSize:  Size.fromHeight(56),
              child: AppBarHomeComponent()),
          body: !commonStore.isKritiAdmin ? const RestrictedPage() : ComingSoon(competition: commonStore.competition),
          bottomNavigationBar: const BottomNavBar(),
        );
      }
    );
  }
}
