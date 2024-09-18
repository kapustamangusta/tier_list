import 'package:flutter/material.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

class MyDraggableWidgets extends StatelessWidget {
  const MyDraggableWidgets(
      {super.key,
      required this.data,
      required this.child,
      required this.onDragStart});

  final String data;
  final Widget child;
  final Function() onDragStart;

  @override
  Widget build(BuildContext context) {
    return DragItemWidget(
      dragItemProvider: (DragItemRequest request) {
        onDragStart();
        final item = DragItem(
          localData: data,
        );
        return item;
      },
      dragBuilder: (context, child) => Opacity(
        opacity: 0.8,
        child: child,
      ),
      allowedOperations: () => [DropOperation.copy],
      child: DraggableWidget(child: child),
    );
  }
}
