import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../globals/colors.dart';

class ShowShimmer extends StatefulWidget {
  const ShowShimmer({Key? key, required this.height, required this.width})
      : super(key: key);
  final double height;
  final double width;
  @override
  State<ShowShimmer> createState() => _ShowShimmerState();
}

class _ShowShimmerState extends State<ShowShimmer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Shimmer.fromColors(
                baseColor: Themes.kShimmerBaseColor,
                highlightColor: Themes.kShimmerHighlightColor,
                child: Container(
                  height: widget.height,
                  width: widget.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Themes.kShimmerBaseColor),
                )),
          ),
        ],
      ),
    );
  }
}
