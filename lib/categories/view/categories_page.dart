import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tier_list_maker/categories/widgets/widgets.dart';
import 'package:tier_list_maker/core/core.dart';


class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<List<String>> upper = [
    [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
    ],
    [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
    ],
  ];
  final List<String> lower = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
  ];

  PanelLocation? dragStart;
  PanelLocation? dropPreview;
  String? hoveringData;

  Size itemSize = Size.zero;
  final int columns = 4;
  final int itemSpacing = 0;
  final double widthLeftPanel = 80;

  void onDragStart(PanelLocation start) {
    String? data;
    if (start.$2 == Panel.lower) {
      data = lower[start.$1];
    } else {
      data = upper[start.$3!][start.$1];
    }

    setState(() {
      dragStart = start;
      hoveringData = data;
    });
  }

  void drop() {
    assert(dropPreview != null, "Биба");
    assert(hoveringData != null, "Боба");
    setState(() {
      if (dragStart != null) {
        if (dragStart!.$2 == Panel.upper) {
          upper[dragStart!.$3!].removeAt(dragStart!.$1);
        } else {
          lower.removeAt(dragStart!.$1);
        }
      }

      if (dropPreview!.$2 == Panel.upper) {
        upper[dropPreview!.$3!].insert(
            min(dropPreview!.$1, upper[dropPreview!.$3!].length),
            hoveringData!);
      } else {
        lower.insert(min(dropPreview!.$1, lower.length), hoveringData!);
      }
      dragStart = null;
      dropPreview = null;
      hoveringData = null;
    });
  }

  void updateDropPreview(PanelLocation update) => setState(() {
        dropPreview = update;
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReorderableListView(
        proxyDecorator: (child, index, animation) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(child: child),
          );
        },
        padding: const EdgeInsets.symmetric(horizontal: 16),
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final List<String> item = upper.removeAt(oldIndex);
            upper.insert(newIndex, item);
          });
        },
        children: [
          CategoryCard(
            key: Key(upper[0].join()),
            color: const Color(0xFFFF7F7F),
            columns: columns,
            itemSpacing: itemSpacing,
            widthLeftPanel: widthLeftPanel,
            items: upper[0],
            onDrop: drop,
            onUpdateDropPreview: (p0) {
              updateDropPreview(p0.copyWith(panelIndex: 0));
            },
            onDragStart: (p0) {
              onDragStart(p0.copyWith(panelIndex: 0));
            },
            dragStart: dragStart?.$2 == Panel.upper && dragStart?.$3 == 0
                ? dragStart
                : null,
            dropPreview: dropPreview?.$2 == Panel.upper && dropPreview?.$3 == 0
                ? dropPreview
                : null,
            hoveringData: dropPreview?.$2 == Panel.upper && dropPreview?.$3 == 0
                ? hoveringData
                : null,
          ),
          CategoryCard(
            key: Key(upper[1].join()),
            color: const Color(0xFFFFBF7F),
            columns: columns,
            itemSpacing: itemSpacing,
            widthLeftPanel: widthLeftPanel,
            items: upper[1],
            onDrop: drop,
            onUpdateDropPreview: (p0) {
              updateDropPreview(p0.copyWith(panelIndex: 1));
            },
            onDragStart: (p0) {
              onDragStart(p0.copyWith(panelIndex: 1));
            },
            dragStart: dragStart?.$2 == Panel.upper && dragStart?.$3 == 1
                ? dragStart
                : null,
            dropPreview: dropPreview?.$2 == Panel.upper && dropPreview?.$3 == 1
                ? dropPreview
                : null,
            hoveringData: dropPreview?.$2 == Panel.upper && dropPreview?.$3 == 1
                ? hoveringData
                : null,
          ),
        ],
      ),
    );
  }
}
