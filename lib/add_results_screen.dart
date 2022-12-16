import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gc_scoreboard/controllers/validation.dart';
import 'package:gc_scoreboard/counter.dart';
import 'package:gc_scoreboard/themes/themes.dart';
import 'package:gc_scoreboard/widgets/drop_down.dart';
import 'package:gc_scoreboard/widgets/text_field.dart';

class AddResult extends StatefulWidget {
  @override
  State<AddResult> createState() => _AddResultState();
}

class _AddResultState extends State<AddResult> {
  List<int> l = [1];
  final TextEditingController _hostel = TextEditingController();

  final TextEditingController _points = TextEditingController();

  final TextEditingController _primaryScore = TextEditingController();

  final TextEditingController _secondaryScore = TextEditingController();

  final _counter = CounterStore();

  String _positionSuffix(int count) {
    if (count == 1) return 'st';
    if (count == 2) return 'nd';
    if (count == 3) return 'rd';
    return 'th';
  }

  int countOf(List<int> l, int x) {
    int ct = 0;
    for (var i = 0; i < l.length; i++) {
      if (l[i] == x) {
        ct++;
      }
    }

    return ct;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.theme.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Themes.theme.backgroundColor,
        shape: Border(
          bottom: BorderSide(
            color: Themes.theme.dividerColor,
            width: 1,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Add Result',
          style: Themes.theme.textTheme.headline2,
        ),
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset('assets/cross.svg'),
          splashColor: const Color.fromRGBO(118, 172, 255, 0.9),
          splashRadius: 24,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Next',
              style: Themes.theme.textTheme.headline3,
            ),
          )
        ],
      ),
      body: Container(
        // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        padding: EdgeInsets.lerp(
            const EdgeInsets.all(8), const EdgeInsets.all(9), 2),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Fields marked with',
                    style: Themes.theme.textTheme.headline4,
                  ),
                  TextSpan(
                    text: ' * ',
                    style: Themes.theme.textTheme.headline5,
                  ),
                  TextSpan(
                    text: 'are compulsory',
                    style: Themes.theme.textTheme.headline4,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '500m Sprint',
                      style: Themes.theme.textTheme.headline1,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Men',
                      style: Themes.theme.textTheme.headline2,
                    ),
                  ],
                ),
                const Spacer(),
                Stack(
                  alignment: const Alignment(0, 0.5),
                  children: [
                    SvgPicture.asset('assets/date.svg'),
                    Text(
                      '18 Feb',
                      style: Themes.theme.textTheme.headline1,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Themes.theme.cardColor,
              ),
              child: Text(
                'Semi-Final',
                style: Themes.theme.textTheme.headline3,
              ),
            ),
            const SizedBox(
              height: 37,
            ),
            Observer(
              builder: (context) {
                return Expanded(
                  child: 
                     ListView.builder(
                      itemCount: l.length,
                      itemBuilder: (context, index) {
                        return Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${l[index]}${_positionSuffix((l[index]))} Position',
                                    style: Themes.theme.textTheme.bodyText2,
                                  ),
                                  const Spacer(),
                                  if (countOf(l, l[index]) < 2)
                                    GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: SvgPicture.asset('assets/plus.svg'),
                                      ),
                                      onTap: () {
                                        
                                        setState(() {
                                          l.add(l[index]);
                                          l.sort();
                                        });
                                      },
                                    ),
                                  if (countOf(l, l[index]) == 2 &&
                                      index != 0 &&
                                      l[index] == l[index - 1])
                                    GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: SvgPicture.asset('assets/minus.svg'),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          l.removeAt(index);

                                          l.sort();
                                        });
                                      },
                                    ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 70,
                                    child: CustomDropDown(),
                                  ),
                                  const Spacer(
                                    flex: 5,
                                  ),
                                  Expanded(
                                      flex: 25,
                                      child: CustomTextField(
                                        hintText: 'Points*',
                                        controller: _points,
                                        validator: validateScore,
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 46,
                                    child: CustomTextField(
                                      hintText: 'Primary Score*',
                                      controller: _primaryScore,
                                      validator: validateScore,
                                    ),
                                  ),
                                  const Spacer(
                                    flex: 6,
                                  ),
                                  Expanded(
                                      flex: 46,
                                      child: CustomTextField(
                                        hintText: 'Secondary Score',
                                        controller: _secondaryScore,
                                        validator: null,
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Divider(
                                thickness: 1,
                                color: Themes.theme.dividerColor,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              if (index == (l.length - 1) &&
                                  l.last < 3)
                                TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        l.add(l[index] + 1);
                                        l.sort();
                                      });
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset('assets/plus.svg'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Add Position',
                                          style: Themes.theme.textTheme.headline3,
                                        )
                                      ],
                                    ))
                            ],
                          ),
                        );
                      },
                    )
                  
                );
              }
            )
          ],
        ),
      ),
    );
  }
}
