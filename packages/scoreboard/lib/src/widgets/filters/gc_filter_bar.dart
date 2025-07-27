import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../stores/gc_store.dart';
import 'filter_button.dart';

class GCFilterBar extends StatefulWidget {
  const GCFilterBar({super.key});

  @override
  State<GCFilterBar> createState() => _GCFilterBarState();
}

class _GCFilterBarState extends State<GCFilterBar> {
  @override
  Widget build(BuildContext context) {
    var gcStore = context.read<GCStore>();
    return Observer(builder: (context) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 99),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(
                children: [
                  FilterButton(
                      label: 'Category',
                      value:
                          'General Championship [${gcStore.selectedCategory.categoryName}]',
                      items: const [
                        'General Championship [Men]',
                        'General Championship [Women]'
                      ],
                      setFunction: (String value) {
                        String a = value == 'General Championship [Men]'
                            ? 'Men'
                            : 'Women';
                        gcStore.changeSelectedCategory(a);
                      })
                ],
              ),
            ]),
          ));
    });
  }
}
