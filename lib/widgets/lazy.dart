import 'package:flutter/material.dart';

class LazyWidget extends StatefulWidget {
  final int itemCount;
  final Widget Function(int) itemBuilder;

  const LazyWidget({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  LazyWidgetState createState() => LazyWidgetState();
}

class LazyWidgetState extends State<LazyWidget> {
  late List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = List.filled(widget.itemCount, Container());
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        if (_children[index] is Container) {
          _children[index] = widget.itemBuilder(index);
        }
        return _children[index];
      },
    );
  }
}
