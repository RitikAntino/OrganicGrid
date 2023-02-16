import 'package:flutter/material.dart';

class OrganicGrid extends StatelessWidget {
  final int count;
  final double childHeight;
  final double paddingHorizontal;
  final double verticalSpacing;
  final double horizontalSpacing;
  final Widget Function(int) itemBuilder;

  const OrganicGrid({
    required this.count,
    required this.itemBuilder,
    this.childHeight = 200,
    this.paddingHorizontal = 0,
    this.verticalSpacing = 8,
    this.horizontalSpacing = 8,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool oddExist = count % 2 != 0;
    final double height;
    final List<Widget> rows = [];

    if (oddExist) {
      height =
          ((childHeight + verticalSpacing) * (count - 1) / 2) + childHeight;
    } else {
      height = (childHeight + verticalSpacing) * count / 2;
    }

    if (oddExist) {
      rows.add(LayoutId(id: 0, child: itemBuilder(0)));
      for (int i = 1; i < count; i++) {
        rows.add(LayoutId(id: i, child: itemBuilder(i)));
      }
    } else {
      for (int i = 1; i <= count; i++) {
        rows.add(LayoutId(id: i, child: itemBuilder(i - 1)));
      }
    }

    return Container(
      constraints: BoxConstraints(maxHeight: height, minHeight: 0),
      child: CustomMultiChildLayout(
        delegate: CustomGridDelegate(
          numRows: rows.length,
          oddExist: oddExist,
          paddingHorizontal: paddingHorizontal,
          verticalSpacing: verticalSpacing,
          horizontalSpacing: horizontalSpacing,
          childHeight: childHeight,
        ),
        children: rows,
      ),
    );
  }
}

class CustomGridDelegate extends MultiChildLayoutDelegate {
  final int numRows;
  final bool oddExist;
  final double paddingHorizontal;
  final double verticalSpacing;
  final double horizontalSpacing;
  final double childHeight;

  CustomGridDelegate({
    required this.numRows,
    required this.oddExist,
    required this.paddingHorizontal,
    required this.verticalSpacing,
    required this.horizontalSpacing,
    required this.childHeight,
  });

  @override
  void performLayout(Size size) {
    double width = size.width - (paddingHorizontal * 2 + horizontalSpacing);
    double dyTotal = childHeight + verticalSpacing;
    double dy = 0;
    double dx = paddingHorizontal;

    void childLayout(int i) {
      positionChild(i, Offset(dx, dy));
      layoutChild(
        i,
        BoxConstraints(minWidth: width / 2, maxWidth: width / 2),
      );
      if (i % 2 == 0) {
        dy += dyTotal;
        dx = paddingHorizontal;
      } else {
        dx = width / 2;
        dx += horizontalSpacing + paddingHorizontal;
      }
    }

    void zerothChildLayout(int i) {
      positionChild(i, Offset(dx, dy));
      layoutChild(
        0,
        BoxConstraints(
            minWidth: width + horizontalSpacing, minHeight: childHeight),
      );
      dy += dyTotal;
    }

    if (oddExist) {
      zerothChildLayout(0);
      for (int i = 1; i < numRows; i++) {
        childLayout(i);
      }
    } else {
      for (int i = 1; i <= numRows; i++) {
        childLayout(i);
      }
    }
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) => false;
}
