// lib/widgets/responsive_grid.dart
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double childAspectRatio;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.childAspectRatio = 0.75,
  });

  int _getCrossAxisCount(double width) {
    if (width < AppConstants.mobileBreakpoint) {
      return 2; // Mobile: 2 columns
    } else if (width < AppConstants.tabletBreakpoint) {
      return 3; // Tablet: 3 columns
    } else {
      return 4; // Desktop: 4 columns
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.count(
          crossAxisCount: _getCrossAxisCount(constraints.maxWidth),
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: children,
        );
      },
    );
  }
}
