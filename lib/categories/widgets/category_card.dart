import 'package:flutter/material.dart';
import 'package:tier_list_maker/categories/widgets/widgets.dart';
import 'package:tier_list_maker/core/core.dart';


class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {super.key,
      required this.columns,
      required this.itemSpacing,
      required this.widthLeftPanel,
      required this.items,
      required this.onDragStart,
      required this.onDrop,
      required this.onUpdateDropPreview,
      this.dragStart,
      this.dropPreview,
      this.hoveringData,
      required this.color});

  final int columns;
  final int itemSpacing;
  final double widthLeftPanel;
  final List<String> items;

  final void Function((int, Panel, int?)) onDragStart;
  final void Function() onDrop;
  final void Function((int, Panel, int?)) onUpdateDropPreview;

  final PanelLocation? dragStart;
  final PanelLocation? dropPreview;
  final String? hoveringData;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            spreadRadius: 0,
            offset: const Offset(0, 4),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final gutters = columns + 1;
          final spaceForColumns =
              constraints.maxWidth - (itemSpacing * gutters) - widthLeftPanel;
          final columnWidth = spaceForColumns / columns;
          final itemSize = Size(columnWidth, columnWidth);

          final heightContent =
              (items.length ~/ columns + 1) * (columnWidth + itemSpacing) +
                  itemSpacing;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CardTitle(
                heightContent: heightContent,
                widthLeftPanel: widthLeftPanel,
                color: color,
              ),
              Flexible(
                flex: 4,
                child: CategoryContent(
                  height: heightContent,
                  width: constraints.maxWidth - widthLeftPanel,
                  itemSize: itemSize,
                  columns: columns,
                  onDrop: onDrop,
                  onUpdateDropPreview: onUpdateDropPreview,
                  onDragStart: onDragStart,
                  items: items,
                  panel: Panel.upper,
                  dragStart: dragStart,
                  dropPreview: dropPreview,
                  hoveringData: hoveringData,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
