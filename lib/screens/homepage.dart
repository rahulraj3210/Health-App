import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/cubit/app_cubits.dart';
import 'package:health_app/models/block.dart';
import '../models/house.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('City View'),
            actions: [
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AppCubits>(context).addHouse();
                  },
                  child: Text(
                    "ADD",
                    style: TextStyle(color: Colors.green),
                  )),
              TextButton(
                child: Text(
                  "Cluster",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  BlocProvider.of<AppCubits>(context).totalCluster();
                },
              ),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AppCubits>(context).removeHouse();
                  },
                  child: Text(
                    "DELETE",
                    style: TextStyle(color: Colors.red),
                  )),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                      "Total Clusters = ${state.blocks[state.currentBlockIndex].clusterCount}"),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10, // Number of columns in the grid
                    crossAxisSpacing: 3.0, // Spacing between columns
                    mainAxisSpacing: 3.0, // Spacing between rows
                  ),
                  itemCount:
                      state.blocks[state.currentBlockIndex].houses.length,
                  itemBuilder: (context, index) {
                    final house =
                        state.blocks[state.currentBlockIndex].houses[index];
                    final clusters =
                        state.blocks[state.currentBlockIndex].clusters;
                    List<House> cluster = [];
                    clusters.forEach((element) {
                      if (element.contains(house)) {
                        cluster.addAll(element);
                      }
                    });
                    return BlockItem(
                      data: house,
                      index: index,
                      cluster: cluster.length,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BlockItem extends StatelessWidget {
  final House data;
  final int index;
  final int cluster;

  BlockItem({required this.data, required this.index, required this.cluster});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<AppCubits>(context).toggleInfected(index);
      },
      child: Card(
        color: data.infected
            ? Colors.red[cluster * 100]
            : Colors.blue, // Customize the color as needed
        child: Center(
          child: Text(
            data.id.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
