import 'package:flutter/material.dart';

class TestGrid extends BoxScrollView {
  TestGrid({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    required this.gridDelegate,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    super.cacheExtent,
    List<Widget> children = const <Widget>[],
    int? semanticChildCount,
    super.dragStartBehavior,
    super.clipBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
  })  : assert(gridDelegate != null),
        childrenDelegate = SliverChildListDelegate(
          children,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
        ),
        super(
          semanticChildCount: semanticChildCount ?? children.length,
        );
  TestGrid.builder({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    required this.gridDelegate,
    required NullableIndexedWidgetBuilder itemBuilder,
    ChildIndexGetter? findChildIndexCallback,
    int? itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    super.cacheExtent,
    int? semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
  })  : assert(gridDelegate != null),
        childrenDelegate = SliverChildBuilderDelegate(
          itemBuilder,
          findChildIndexCallback: findChildIndexCallback,
          childCount: itemCount,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
        ),
        super(
          semanticChildCount: semanticChildCount ?? itemCount,
        );

  final SliverGridDelegate gridDelegate;

  final SliverChildDelegate childrenDelegate;

  @override
  Widget buildChildLayout(BuildContext context) {
    return SliverGrid(
      delegate: childrenDelegate,
      gridDelegate: gridDelegate,
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
