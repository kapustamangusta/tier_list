import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:tier_list_maker/categories/widgets/widgets.dart';
import 'package:tier_list_maker/core/core.dart';

class ItemPanel extends StatelessWidget {
  const ItemPanel(
      {super.key,
      required this.crossAxisCount,
      required this.items,
      required this.spacing,
      required this.onDragStart,
      required this.panel,
      required this.dragStart,
      this.dropPreview,
      required this.hoveringData});

  final int crossAxisCount;
  final List<String> items;
  final PanelLocation? dragStart;
  final Function(PanelLocation) onDragStart;
  final Panel panel;
  final double spacing;
  final PanelLocation? dropPreview;
  final String? hoveringData;

  @override
  Widget build(BuildContext context) {
    final itemsCopy = List<String>.from(items);

    PanelLocation? dragStartCopy;
    if (dragStart != null) {
      dragStartCopy = dragStart!.copyWith();
    }

    PanelLocation? dropPreviewCopy;
    if (dropPreview != null && hoveringData != null) {
      dropPreviewCopy = dropPreview!.copyWith(
        index: min(items.length, dropPreview!.$1),
      );
      if (dragStartCopy?.$2 == dropPreviewCopy.$2) {
        itemsCopy.removeAt(dragStartCopy!.$1);
        dragStartCopy = null;
      }
      itemsCopy.insert(min(dropPreview!.$1, itemsCopy.length), hoveringData!);
    }

    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      padding: const EdgeInsets.all(0),
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      children: itemsCopy.asMap().entries.map<Widget>(
        (MapEntry<int, String> entry) {
          Color textColor =
              entry.key == dragStartCopy?.$1 || entry.key == dropPreviewCopy?.$1
                  ? Colors.grey
                  : Colors.white;

          Widget child = Center(
            child: Text(
              entry.value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 36, color: textColor),
            ),
          );
          if (entry.key == dragStartCopy?.$1) {
            child = Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: child,
            );
          } else if (entry.key == dropPreviewCopy?.$1) {
            child = DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(8),
              dashPattern: const [10, 10],
              color: Colors.grey,
              strokeWidth: 2,
              child: child,
            );
          } else {
            child = Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: child,
            );
          }

          return MyDraggableWidgets(
            data: entry.value,
            child: child,
            onDragStart: () => onDragStart((entry.key, panel, null)),
          );
        },
      ).toList(),
    );
  }
}
