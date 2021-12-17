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
                  ..strokeWidth = 10
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
              BoxShadow(color: Colors.purple, spreadRadius: 1),
            ],
          ),
          child: Text('${a}')),
    );
  }

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    final octavos1 = Node.Id('octavos1');
    final octavos2 = Node.Id('octavos2');
    final octavos3 = Node.Id('octavos3');
    final octavos4 = Node.Id('octavos4');
    final octavos5 = Node.Id('octavos5');
    final octavos6 = Node.Id('octavos6');
    final octavos7 = Node.Id('octavos7');
    final octavos8 = Node.Id('octavos8');
    final cuartos1 = Node.Id('cuartos1');
    final cuartos2 = Node.Id('cuartos2');
    final cuartos3 = Node.Id('cuartos3');
    final cuartos4 = Node.Id('cuartos4');
    final semiFinal1 = Node.Id('semifnal1');
    final semiFinal2 = Node.Id('semifnal2');
    final finalWinner = Node.Id('final');

    graph.addEdge(cuartos1, octavos1, paint: Paint()..color = Colors.green);
    graph.addEdge(cuartos1, octavos2, paint: Paint()..color = Colors.red);
    graph.addEdge(cuartos2, octavos3, paint: Paint()..color = Colors.green);
    graph.addEdge(cuartos2, octavos4, paint: Paint()..color = Colors.red);

    graph.addEdge(cuartos3, octavos5, paint: Paint()..color = Colors.green);
    graph.addEdge(cuartos3, octavos6, paint: Paint()..color = Colors.red);

    graph.addEdge(cuartos4, octavos7, paint: Paint()..color = Colors.green);
    graph.addEdge(cuartos4, octavos8, paint: Paint()..color = Colors.red);

    graph.addEdge(semiFinal1, cuartos1, paint: Paint()..color = Colors.green);
    graph.addEdge(semiFinal1, cuartos2, paint: Paint()..color = Colors.red);

    graph.addEdge(semiFinal2, cuartos3, paint: Paint()..color = Colors.red);
    graph.addEdge(semiFinal2, cuartos4, paint: Paint()..color = Colors.green);

    graph.addEdge(finalWinner, semiFinal2, paint: Paint()..color = Colors.red);
    graph.addEdge(finalWinner, semiFinal1,
        paint: Paint()..color = Colors.green);

    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (30)
      ..subtreeSeparation = (30)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_RIGHT_LEFT);
  }
}
