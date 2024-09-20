import 'package:flutter/material.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

class DropHoverRegion extends StatelessWidget {
  const DropHoverRegion({
    super.key,
    this.onDropHover,
  });

  final VoidCallback? onDropHover;

  @override
  Widget build(BuildContext context) {
    return DropRegion(
      formats: Formats.standardFormats,
      onDropOver: (p0) async {
        onDropHover?.call();

        return DropOperation.userCancelled;
      },
      onPerformDrop: (PerformDropEvent) async {},
      child: Container(
        color: Colors.white.withOpacity(0.01),
        height: 100,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
