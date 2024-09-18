import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  const CardTitle({
    super.key,
    required this.heightContent,
    required this.widthLeftPanel,
    required this.color,
  });

  final double heightContent;
  final double widthLeftPanel;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightContent,
      width: widthLeftPanel,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Text(
          "A",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
    );
  }
}
