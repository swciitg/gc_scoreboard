import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onestop_ui/index.dart';
import 'package:provider/provider.dart';
import '../../globals/enums.dart';
import '../../globals/styles.dart';
import '../../stores/common_store.dart';
import '../../stores/gc_store.dart';
import '../../stores/kriti_store.dart';
import '../../stores/manthan_store.dart';
import '../../stores/sahyog_store.dart';
import '../../stores/spardha_store.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    return Padding(
      padding: EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: Platform.isIOS ? 8 : bottomInset,
      ),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: OColor.white,
          borderRadius: BorderRadius.circular(
              Platform.isIOS ? 40 : OCornerRadius.l),
          boxShadow: [
            BoxShadow(
              color: OColor.black.withValues(alpha: 0.06),
              blurRadius: 9,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: OColor.black.withValues(alpha: 0.03),
              blurRadius: 17,
              offset: const Offset(0, 16),
            ),
            BoxShadow(
              color: OColor.black.withValues(alpha: 0.02),
              blurRadius: 23,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          children: Competitions.values.map((competition) {
            return Expanded(
              child: _BottomNavBarItem(competition: competition),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _BottomNavBarItem extends StatelessWidget {
  final Competitions competition;

  const _BottomNavBarItem({required this.competition});

  @override
  Widget build(BuildContext context) {
    CommonStore commonStore = context.read<CommonStore>();

    dynamic competitionStore;
    switch (competition) {
      case Competitions.gc:
        competitionStore = context.read<GCStore>();
        break;
      case Competitions.spardha:
        competitionStore = context.read<SpardhaStore>();
        break;
      case Competitions.kriti:
        competitionStore = context.read<KritiStore>();
        break;
      case Competitions.manthan:
        competitionStore = context.read<ManthanStore>();
        break;
      case Competitions.sahyog:
        competitionStore = context.read<SahyogStore>();
        break;
    }

    return Observer(builder: (context) {
      final isSelected = commonStore.competition == competition;
      return GestureDetector(
        onTap: () {
          commonStore.setCompetition(competition, competitionStore);
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected ? OColor.green100 : null,
            borderRadius: BorderRadius.circular(
                Platform.isIOS ? 40 : OCornerRadius.m),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: SvgPicture.asset(
                  competition.assetPath,
                  package: 'scoreboard',
                  colorFilter: ColorFilter.mode(
                    isSelected ? OColor.green600 : OColor.gray800,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                competition.name,
                style: (isSelected ? bottomNavStyle2 : bottomNavStyle1)
                    .copyWith(
                  color: isSelected ? OColor.green600 : OColor.gray800,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
