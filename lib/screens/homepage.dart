import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/cubit/app_cubits.dart';
import '../models/house.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Block View'),
            actions: [
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AppCubits>(context).addHouse();
                  },
                  child: Text(
                    "ADD",
                    style: TextStyle(color: Colors.green),
                  )),
              IconButton(
                icon: Icon(Icons.details),
                onPressed: () {
                  BlocProvider.of<AppCubits>(context).totalCluster();
                },
              ),
            ],
          ),
          body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10, // Number of columns in the grid
              crossAxisSpacing: 3.0, // Spacing between columns
              mainAxisSpacing: 3.0, // Spacing between rows
            ),
            itemCount: state.houses.length,
            itemBuilder: (context, index) {
              return BlockItem(
                data: state.houses[index],
                index: index,
              );
            },
          ),
        );
      },
    );
  }
}

class BlockItem extends StatelessWidget {
  final House data;
  final int index;

  BlockItem({required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<AppCubits>(context).toggleInfected(index);
      },
      child: Card(
        color: data.infected
            ? Colors.red
            : Colors.blue, // Customize the color as needed
        child: Center(
          child: Text(
            data.id.toString(),
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
