import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../globals/colors.dart';


class ShowShimmer extends StatefulWidget {
  const ShowShimmer({Key? key, required this.height, required this.width}) : super(key: key);
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Themes.kShimmerBase,
              highlightColor: Themes.kShimmerHighlight,
              child: Container(
                height: widget.height,
                width: widget.width,
                margin: EdgeInsets.fromLTRB(4, 16, 4, 0),
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(24),color:Themes.kShimmerBase),
              )
            ),
          ),
        ],
      ),
    );
  }
}
