import 'package:flutter/material.dart';
import '../../../globals/constants.dart';
import '../../../globals/styles.dart';

class BiHostelView extends StatelessWidget {
  final String hostelA;
  final String hostelB;
  const BiHostelView({Key? key, required this.hostelA, required this.hostelB})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 18,
                width: 18,
                child: Image.asset(
                  hostelsImagePath[hostelA]!,
                  cacheWidth: 50,
                  cacheHeight: 50,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                hostelA,
                style: cardVenueStyle3,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
          height: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 18,
                width: 18,
                child: Image.asset(
                  hostelsImagePath[hostelB]!,
                  cacheWidth: 50,
                  cacheHeight: 50,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                hostelB,
                style: cardVenueStyle3,
              )
            ],
          ),
        ),
      ],
    );
  }
}
