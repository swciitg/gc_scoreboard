import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/models/event_model.dart';
import '../functions/validation.dart';

import '../stores/counter.dart';
import '../globals/themes.dart';
import '../widgets/drop_down.dart';
import '../widgets/text_field.dart';

class AddResult extends StatelessWidget {


  final TextEditingController _points = TextEditingController();

  final TextEditingController _primaryScore = TextEditingController();

  final TextEditingController _secondaryScore = TextEditingController();


  AddResult({super.key});

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
    EventModel event = context.read<CounterStore>().event;
    CounterStore _counter = context.read<CounterStore>();
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
          icon: Icon(
            Icons.close,
            color: Themes.theme.primaryColor,
          ),
          splashColor: const Color.fromRGBO(118, 172, 255, 0.9),
        ),
        actions: [
          TextButton(
            onPressed: () {
            
            },
            child: Text(
              'Next',
              style: Themes.theme.textTheme.headline3,
            ),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                      event.name,
                      style: Themes.theme.textTheme.headline1,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      event.category,
                      style: Themes.theme.textTheme.headline2,
                    ),
                  ],
                ),
                const Spacer(),
                Stack(
                  alignment: const Alignment(0, 0.5),
                  children: [
                    SvgPicture.asset('packages/scoreboard/assets/date.svg'),
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
                event.stage,
                style: Themes.theme.textTheme.headline3,
              ),
            ),
            const SizedBox(
              height: 37,
            ),
            Expanded(child: Observer(builder: (_) {
              return ListView.builder(
                itemCount: _counter.l.length,
                itemBuilder: (context, index) {
                  return Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${_counter.l[index]}${_positionSuffix((_counter.l[index]))} Position',
                              style: Themes.theme.textTheme.bodyText2,
                            ),
                            const Spacer(),
                            if (countOf(_counter.l, _counter.l[index]) < 2)
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.add,
                                    color: Themes.theme.primaryColor,
                                  ),
                                ),
                                onTap: () {
                           
                                  _counter.addSame(_counter.l[index]);
                         
                                },
                              ),
                            if (countOf(_counter.l, _counter.l[index]) == 2 &&
                                index != 0 &&
                                _counter.l[index] == _counter.l[index - 1])
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.remove,
                                    color: Themes.theme.errorColor,
                                  ),
                                ),
                                onTap: () {
                                  _counter.removeSame(index);
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
                        if (index == (_counter.l.length - 1) &&
                            _counter.l.last < 3)
                          TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () {
                                _counter.addDifferent(_counter.l[index]);
                            
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Themes.theme.primaryColor,
                                  ),
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
              );
            }))
          ],
        ),
      ),
    );
  }
}
