import 'dart:math';
import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphview/GraphView.dart';

class TreeOfElerinatScreen extends StatefulWidget {
  const TreeOfElerinatScreen({super.key});

  @override
  State<TreeOfElerinatScreen> createState() => _TreeOfElerinatScreenState();
}

class _TreeOfElerinatScreenState extends State<TreeOfElerinatScreen> {
  @override
  Widget build(BuildContext context) {
    return BackGroundAndAppBarAndDaynamicBody(
        alignmentTitle: Alignment.center,
        titleName: MStrings.treeOfElerinat,
        yourBodyOfScreen: Positioned.fill(
            top: 130.h,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: InteractiveViewer(
                      constrained: false,
                      boundaryMargin: const EdgeInsets.all(25),
                      minScale: 0.00001,
                      maxScale: 5.0,
                      child: GraphView(
                        graph: graph,
                        algorithm: BuchheimWalkerAlgorithm(
                            builder, TreeEdgeRenderer(builder)),
                        paint: Paint()
                          ..color = Colors.white
                          ..strokeWidth = 3
                          ..style = PaintingStyle.fill,
                        builder: (Node node) {
                          // I can decide what widget should be shown here based on the id
                          var a = node.key!.value as int;
                          return rectangleWidget(a);
                        },
                      )),
                ),
              ],
            )));
  }

  Random r = Random();

  Widget rectangleWidget(int a) {
    return InkWell(
      onTap: () {
        // print('clicked');
      },
      child: Container(
          width: 220.w,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(color: ColorManger.white, spreadRadius: 2),
            ],
          ),
          child: Column(
            children: [
              Text(
                '$a ابراهيم الملقب باللحيدان',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 14.w),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                '1793 - 1850  ',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 14.w),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width,
                color: ColorManger.logoColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.add_circle,
                        size: 25.h,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (a == 1) {
                          addNodes();
                        } else if (a == 4) {
                          addNode();
                        } else {
                          addNode5();
                        }
                      },
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      '3548',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontSize: 14.w),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      ': عدد الاولاد ',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontSize: 14.w),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  final Graph graph = Graph()..isTree = true;

  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();
    final node1 = Node.Id(1);

    graph.addNode(node1);

    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }

  void addNodes() {
    final node2 = Node.Id(2);
    final node3 = Node.Id(3);
    final node4 = Node.Id(4);
    graph.addEdge(Node.Id(1), node2);
    graph.addEdge(Node.Id(1), node3);
    graph.addEdge(Node.Id(1), node4);
    setState(() {});
  }

  void addNode() {
    final node5 = Node.Id(5);
    final node6 = Node.Id(6);
    final node7 = Node.Id(7);
    graph.addEdge(Node.Id(4), node5);
    graph.addEdge(Node.Id(4), node6);
    graph.addEdge(Node.Id(4), node7);
    setState(() {});
  }

  void addNode5() {
    final node8 = Node.Id(8);
    final node9 = Node.Id(9);
    final node10 = Node.Id(10);
    graph.addEdge(Node.Id(3), node8);
    graph.addEdge(Node.Id(3), node9);
    graph.addEdge(Node.Id(3), node10);
    setState(() {});
  }
}




    // Wrap(
                //   children: [
                //     Container(
                //       width: 100,
                //       child: TextFormField(
                //         initialValue: builder.siblingSeparation.toString(),
                //         decoration:
                //             InputDecoration(labelText: "Sibling Separation"),
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
                //         decoration:
                //             InputDecoration(labelText: "Level Separation"),
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
                //         decoration:
                //             InputDecoration(labelText: "Subtree separation"),
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
                //         var edge = graph
                //             .getNodeAtPosition(r.nextInt(graph.nodeCount()));
                //         print(edge);
                //         graph.addEdge(edge, node12);
                //         setState(() {});
                //       },
                //       child: Text("Add"),
                //     )
                //   ],
                // ),

                 // final node2 = Node.Id(2);
    // final node3 = Node.Id(3);
    // final node4 = Node.Id(4);
    // final node5 = Node.Id(5);
    // final node6 = Node.Id(6);
    // final node8 = Node.Id(7);
    // final node7 = Node.Id(8);
    // final node9 = Node.Id(9);
    // final node10 = Node.Id(10);
    // final node11 = Node.Id(11);
    // final node12 = Node.Id(12);
    // final node13 = Node.Id(13);
    // final node14 = Node.Id(14);

     // graph.addEdge(
    //   node1,
    //   node3,
    //   paint: Paint()..color = Colors.red,
    // );
    // graph.addEdge(node1, node4, paint: Paint()..color = Colors.blue);
    // graph.addEdge(node2, node5);
    // graph.addEdge(node2, node6);
    // graph.addEdge(node6, node7, paint: Paint()..color = Colors.red);
    // graph.addEdge(node6, node8, paint: Paint()..color = Colors.red);
    // graph.addEdge(node4, node9);
    // graph.addEdge(node4, node10, paint: Paint()..color = Colors.black);
    // graph.addEdge(node4, node11, paint: Paint()..color = Colors.red);
    // graph.addEdge(node11, node12);
    // graph.addEdge(node7, node14);