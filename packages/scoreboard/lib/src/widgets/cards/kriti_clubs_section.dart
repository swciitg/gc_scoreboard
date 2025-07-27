import 'package:flutter/material.dart';
import '../../globals/colors.dart';
import '../../globals/styles.dart';

class ClubsListSection extends StatelessWidget {
  final List<String> clubs;

  const ClubsListSection({super.key,required this.clubs});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: clubs.length + 1,
          itemBuilder: (context,idx){
            if(idx==0){
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text("Problem contributors: ",style: fontStyle3,),
              );
            }
            return SizedBox(
              height: 18,
              child: Row(
                children: [
                  const Icon(
                    Icons.fiber_manual_record,
                    size: 4,
                    color: Themes.cardFontColor2,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(clubs[idx-1],overflow: TextOverflow.ellipsis,
                    style: cardVenueStyle2,)
                ],
              ),
            );
          }),
    );
  }
}