import 'package:flutter/material.dart';
import 'package:tier_list_maker/categories/widgets/widgets.dart';
import 'package:tier_list_maker/core/models/types.dart';


class CategoryContent extends StatefulWidget {
  const CategoryContent(
      {super.key,
      this.columns = 4,
      this.itemSpacing = 0,
      required this.onDrop,
      required this.onUpdateDropPreview,
      required this.onDragStart,
      required this.items,
      this.dragStart,
      this.dropPreview,
      this.hoveringData,
      required this.panel, required this.height, required this.width, required this.itemSize, });

  final int columns;
  final double itemSpacing;

  final void Function() onDrop;
  final void Function(PanelLocation update) onUpdateDropPreview;
  final void Function(PanelLocation start) onDragStart;

  final Panel panel;
  final List<String> items;
  final PanelLocation? dragStart;
  final PanelLocation? dropPreview;
  final String? hoveringData;

  final double height;
  final double width;
  final Size itemSize;

  @override
  State<CategoryContent> createState() => _CategoryContentState();
}

class _CategoryContentState extends State<CategoryContent> {

 
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: MyDropRegion(
        onDrop: widget.onDrop,
        updateDropPreview: widget.onUpdateDropPreview,
        columns: widget.columns,
        childSize: widget.itemSize,
        panel: widget.panel,
        child: ItemPanel(
          crossAxisCount: widget.columns,
          items: widget.items,
          dragStart: widget.dragStart,
          dropPreview: widget.dropPreview,
          hoveringData: widget.hoveringData,
          onDragStart: widget.onDragStart,
          panel: widget.panel,
          spacing: widget.itemSpacing,
        ),
      ),
    );
  }
}
