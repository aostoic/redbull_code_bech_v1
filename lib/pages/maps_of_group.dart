import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/models/models.dart';
import 'package:redbull_code_bech_v1/pages/pages.dart';
import 'package:redbull_code_bech_v1/services/services.dart';
import 'package:redbull_code_bech_v1/widgets/buttons/primary_button.dart';

class MapsOfGroupPage extends StatelessWidget {
  static String routeName = '/maps_of_group';

  const MapsOfGroupPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: TreeViewPage(),
      );
}

class TreeViewPage extends StatefulWidget {
  @override
  _TreeViewPageState createState() => _TreeViewPageState();
}

class _TreeViewPageState extends State<TreeViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        // Wrap(
        //   children: [
        //     Container(
        //       width: 100,
        //       child: TextFormField(
        //         initialValue: builder.siblingSeparation.toString(),
        //         decoration: InputDecoration(labelText: "Sibling Separation"),
        //         onChanged: (text) {
        //           builder.siblingSeparation = int.tryParse(text) ?? 100;
        //           this.setState(() {});
        //         },
        //       ),
        //     ),
        //     Container(
        //       width: 100,
        //       child: TextFormField(
        //         initialValue: builder.levelSeparation.toString(),
        //         decoration: InputDecoration(labelText: "Level Separation"),
        //         onChanged: (text) {
        //           builder.levelSeparation = int.tryParse(text) ?? 100;
        //           this.setState(() {});
        //         },
        //       ),
        //     ),
        //     Container(
        //       width: 100,
        //       child: TextFormField(
        //         initialValue: builder.subtreeSeparation.toString(),
        //         decoration: InputDecoration(labelText: "Subtree separation"),
        //         onChanged: (text) {
        //           builder.subtreeSeparation = int.tryParse(text) ?? 100;
        //           this.setState(() {});
        //         },
        //       ),
        //     ),
        //     Container(
        //       width: 100,
        //       child: TextFormField(
        //         initialValue: builder.orientation.toString(),
        //         decoration: InputDecoration(labelText: "Orientation"),
        //         onChanged: (text) {
        //           builder.orientation = int.tryParse(text) ?? 100;
        //           this.setState(() {});
        //         },
        //       ),
        //     ),
        //     ElevatedButton(
        //       onPressed: () {
        //         final node12 = Node.Id(r.nextInt(100));
        //         var edge =
        //             graph.getNodeAtPosition(r.nextInt(graph.nodeCount()));
        //         print(edge);
        //         graph.addEdge(edge, node12);
        //         setState(() {});
        //       },
        //       child: Text("Add"),
        //     )
        //   ],
        // ),
        Expanded(
          child: InteractiveViewer(
              constrained: false,
              boundaryMargin: EdgeInsets.all(100),
              minScale: 0.01,
              maxScale: 5.6,
              child: GraphView(
                graph: graph,
                algorithm:
                    BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
                paint: Paint()
                  ..color = Colors.green
                  ..strokeWidth = 1
                  ..style = PaintingStyle.stroke,
                builder: (Node node) {
                  // I can decide what widget should be shown here based on the id
                  var a = node.key!.value;
                  return rectangleWidget(a);
                },
              )),
        ),
      ],
    ));
  }

  Random r = Random();

  Widget rectangleWidget(a) {
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(color: Colors.deepOrange, spreadRadius: 1),
            ],
          ),
          child: Text('${a}')),
    );
  }

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    final node1 = Node.Id("que pasa");
    final node2 = Node.Id(2);
    final node3 = Node.Id(3);
    final node4 = Node.Id(4);
    final node5 = Node.Id(5);
    final node6 = Node.Id(6);
    final node7 = Node.Id(7);
    final node8 = Node.Id(8);
    final node9 = Node.Id(9);
    final node10 = Node.Id(10);
    final node11 = Node.Id(11);
    final node12 = Node.Id(12);
    final node13 = Node.Id(13);

    graph.addEdge(node1, node6, paint: Paint()..color = Colors.red);
    graph.addEdge(node6, node7, paint: Paint()..color = Colors.red);
    graph.addEdge(node6, node8, paint: Paint()..color = Colors.red);

    graph.addEdge(node1, node11, paint: Paint()..color = Colors.blue);
    graph.addEdge(node11, node12);
    graph.addEdge(node11, node13);

    graph.addEdge(node1, node2, paint: Paint()..color = Colors.blue);
    graph.addEdge(node11, node12);

    builder
      ..siblingSeparation = (10)
      ..levelSeparation = (40)
      ..subtreeSeparation = (40)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }
}
