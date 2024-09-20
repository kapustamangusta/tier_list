import 'dart:math';

import 'package:flutter/material.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';
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
      'A',
      'B',
      'C',
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'A',
      'B',
      'C',
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'A',
      'B',
      'C',
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'A',
      'B',
      'C',
    ],
    [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
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
  final double heightLowerPanel = 120;
  bool pinned = false;

  final ScrollController _scrollController = ScrollController();

  void onDragStart(PanelLocation start) {
    String? data;
    if (start.$2 == Panel.lower) {
      data = lower[start.$1];
    } else {
      data = upper[start.$3!][start.$1];
    }

    setState(() {
      pinned = true;
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
      pinned = false;
    });
  }

  void updateDropPreview(PanelLocation update) => setState(() {
        dropPreview = update;

        // _scrollController.jumpTo(_scrollController.offset - 10);
      });
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Фильмы"),
      //   actions: [
      //     IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
      //   ],
      // ),
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: false,
                title: const Text("Фильмы"),
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
                ],
              ),
              SliverReorderableList(
                proxyDecorator: (child, index, animation) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Transform.scale(
                      scale: 0.5,
                      child: Container(child: child),
                    ),
                  );
                },
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final List<String> item = upper.removeAt(oldIndex);
                    upper.insert(newIndex, item);
                  });
                },
                itemCount: upper.length,
                itemBuilder: (context, index) =>
                    ReorderableDelayedDragStartListener(
                  key: Key(upper[index].join()),
                  index: index,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 16,
                    ),
                    child: CategoryCard(
                      color: const Color(0xFFFF7F7F),
                      columns: columns,
                      itemSpacing: itemSpacing,
                      widthLeftPanel: widthLeftPanel,
                      items: upper[index],
                      onDrop: drop,
                      onUpdateDropPreview: (p0) {
                        updateDropPreview(p0.copyWith(panelIndex: index));
                      },
                      onDragStart: (p0) {
                        onDragStart(p0.copyWith(panelIndex: index));
                      },
                      dragStart:
                          dragStart?.$2 == Panel.upper && dragStart?.$3 == index
                              ? dragStart
                              : null,
                      dropPreview: dropPreview?.$2 == Panel.upper &&
                              dropPreview?.$3 == index
                          ? dropPreview
                          : null,
                      hoveringData: dropPreview?.$2 == Panel.upper &&
                              dropPreview?.$3 == index
                          ? hoveringData
                          : null,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: heightLowerPanel,
                  width: MediaQuery.of(context).size.width,
                ),
              )
            ],
          ),
          pinned
              ? DropRegion(
                  formats: Formats.standardFormats,
                  onDropOver: (p0) async {
                    _scrollController.jumpTo(_scrollController.offset - 5);

                    return DropOperation.userCancelled;
                  },
                  onPerformDrop: (PerformDropEvent) async {},
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                  ),
                )
              : const SizedBox(),
          pinned
              ? Positioned(
                  bottom: 0,
                  child: DropRegion(
                    formats: Formats.standardFormats,
                    onDropOver: (p0) async {
                      _scrollController.jumpTo(_scrollController.offset + 5);

                      return DropOperation.none;
                    },
                    onPerformDrop: (PerformDropEvent) async {},
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
