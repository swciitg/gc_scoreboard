import 'package:flutter/material.dart';
import '../../globals/colors.dart';
import '../../globals/styles.dart';

class ErrorReloadPage extends StatefulWidget {
  final Function apiFunction;
  const ErrorReloadPage({super.key, required this.apiFunction});

  @override
  State<ErrorReloadPage> createState() => _ErrorReloadPageState();
}

class _ErrorReloadPageState extends State<ErrorReloadPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              "Oops!",
              style: fontStyle2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "Looks like you’ve run into an error. Please reload to resolve the issue.",
              style: bottomNavStyle1,
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              widget.apiFunction();
            },
            icon: const Icon(
              Icons.rotate_right,
              size: 16,
              color: Themes.kBlack,
            ),
            label: const Text("Try again",
                style: TextStyle(
                    color: Themes.kBlack,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Themes.kYellow)),
          )
        ],
      ),
    );
  }
}
