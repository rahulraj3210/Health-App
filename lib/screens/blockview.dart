import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/cubit/app_cubits.dart';
import 'package:health_app/cubit/app_cubits_logic.dart';
import '../models/house.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_app/models/house.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_app/screens/homepage.dart';

class BlockView extends StatelessWidget {
  const BlockView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitState>(
      builder: (context, state) {
        print(state.blocks.length);
        return Scaffold(
            appBar: AppBar(
              title: Text('BLOCK VIEW'),
              actions: [
                TextButton(
                    onPressed: () {
                      BlocProvider.of<AppCubits>(context).addBlock();
                    },
                    child: Text(
                      "ADD",
                      style: TextStyle(color: Colors.green),
                    )),
                TextButton(
                    onPressed: () {
                      BlocProvider.of<AppCubits>(context).removeblock();
                    },
                    child: Text(
                      "DELETE",
                      style: TextStyle(color: Colors.red),
                    )),
              ],
            ),
            body: ListView.builder(
              itemBuilder: (context, index) {
                final block = state.blocks[index];
                print(block);
                return ListTile(
                  title: Text("Block Number =${block.id}"),
                  onTap: () {
                    BlocProvider.of<AppCubits>(context).setCurrentBlock(index);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                                  value: BlocProvider.of<AppCubits>(context),
                                  child: HomePage(),
                                )));
                  },
                  subtitle: Text("Cluster Count=${block.clusterCount}"),
                );
              },
              itemCount: state.blocks.length,
            ));
      },
    );
  }
}
