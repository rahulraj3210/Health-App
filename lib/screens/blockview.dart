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
    return Scaffold(
      appBar: AppBar(
        title: Text('BLOCK VIEW'),
      ),
      body: Card(
        child: ListTile(
          title: Text('Block A'),
          leading: Image(
            image: NetworkImage(
                'https://upload.wikimedia.org/wikipedia/commons/d/da/Willard_Richmond_Apartment_Block_Worcester_MA.jpg'),
          ),
          trailing: Icon(Icons.arrow_forward_rounded),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider<AppCubits>(
                  create: (context) => AppCubits(),
                  child: AppCubitLogics(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
