import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/organic_grid.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Random rand = Random();
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OrganicGrid(
              count: 15,
              itemBuilder: (index) {
                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(
                      rand.nextInt(255),
                      rand.nextInt(255),
                      rand.nextInt(255),
                      1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Text Box ${++index}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PackageGrid extends StatelessWidget {
  final int count;
  const PackageGrid({required this.count, super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: StaggeredGridView.countBuilder(
        // shrinkWrap: true,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        crossAxisCount: 4,
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.green,
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text('$index'),
              ),
            ),
          );
        },
        staggeredTileBuilder: (int index) {
          if (count % 2 != 0 && index == 0) {
            return const StaggeredTile.count(5, 1);
          }
          return const StaggeredTile.count(2, 1);
        },
      ),
    );
  }
}

class Grid extends StatelessWidget {
  final List<Widget> widgetList;
  const Grid({
    required this.widgetList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        itemCount: widgetList.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8),
        itemBuilder: (BuildContext context, int index) {
          var currentItem = widgetList[index];
          return currentItem;
        },
      ),
    );
  }
}
