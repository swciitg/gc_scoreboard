import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../functions/auth_user_helper.dart';
import '../../functions/snackbar.dart';
import '../../globals/constants.dart';
import '../../globals/colors.dart';
import '../../globals/enums.dart';
import '../../screens/home.dart';
import '../../screens/login/admin_login.dart';
import '../../stores/common_store.dart';

class StandingsAppBar extends StatefulWidget {
  const StandingsAppBar({Key? key}) : super(key: key);

  @override
  State<StandingsAppBar> createState() => _StandingsAppBarState();
}

class _StandingsAppBarState extends State<StandingsAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Themes.appbarBackgroundColor,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 80,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Themes.cardColor1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.arrow_back_outlined,
                        size: 16,
                        color: Themes.primaryColor,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text('One',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Themes.primaryColor)),
                      Text('.',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Themes.cardFontColor3)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
