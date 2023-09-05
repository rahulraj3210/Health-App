import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_app/models/block.dart';
import 'package:health_app/models/house.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_app/screens/homepage.dart';
part 'app_cubits.freezed.dart';
part 'app_states.dart';

const blockCollection = 'Block_list';

class AppCubits extends Cubit<CubitState> {
  AppCubits() : super(CubitState()) {
    init();
  }
  Stream<List<Block>> readhouse() => FirebaseFirestore.instance
      .collection(blockCollection)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Block.fromJson(doc.data()).copyWith(docId: doc.id))
          .toList());
  void init() {
    readhouse().listen((blocksss) {
      print(blocksss);
      blocksss.sort((a, b) => a.id.compareTo(b.id));
      emit(state.copyWith(blocks: blocksss));
      totalCluster();
    });
  }

  void setCurrentBlock(int index) {
    emit(state.copyWith(currentBlockIndex: index));
  }

  Future addBlock() async {
    final List<Block> blocks = List.from(state.blocks);

    final doc = FirebaseFirestore.instance.collection(blockCollection).doc();
    final id = blocks.isEmpty ? 0 : blocks.last.id;
    final newBlock = Block(id: id + 1, docId: doc.id);
    print(newBlock);
    print(newBlock.docId);
    blocks.add(newBlock);
    var json = newBlock.toJson();
    json["clusters"] = [];
    await FirebaseFirestore.instance
        .collection(blockCollection)
        .doc(newBlock.docId)
        .set(json);
    emit(state.copyWith(blocks: blocks));
  }

  Future removeblock() async {
    final List<Block> blocks = List.from(state.blocks);
    if (blocks.isNotEmpty) {
      final lastBlock = blocks.last;
      blocks.removeLast();
      await FirebaseFirestore.instance
          .collection(blockCollection)
          .doc(lastBlock.docId)
          .delete();
      emit(state.copyWith(blocks: blocks));
    }
  }

  Future addHouse() async {
    final List<Block> blocks = List.from(state.blocks);
    final index = state.currentBlockIndex;
    final currentBLock = blocks[index];
    final List<House> list = List.from(currentBLock.houses);
    final newHouse = House(id: list.last.id + 1);
    list.add(newHouse);
    final newBLock = currentBLock.copyWith(houses: list);
    blocks.replaceRange(index, index + 1, [newBLock]);
    var json = newBLock.toJson();
    json["clusters"] = [];
    await FirebaseFirestore.instance
        .collection(blockCollection)
        .doc(newBLock.docId)
        .set(json);
    emit(state.copyWith(blocks: blocks));
  }

  Future removeHouse() async {
    final List<Block> blocks = List.from(state.blocks);
    final List<House> houses =
        List.from(blocks[state.currentBlockIndex].houses);
    houses.removeLast();
    final currentBLock = blocks[state.currentBlockIndex];
    final newHouseBlock = currentBLock.copyWith(houses: houses);
    blocks.removeAt(state.currentBlockIndex);
    blocks.insert(state.currentBlockIndex, newHouseBlock);
    var json = newHouseBlock.toJson();
    json["clusters"] = [];
    await FirebaseFirestore.instance
        .collection(blockCollection)
        .doc(newHouseBlock.docId)
        .set(json);

    emit(state.copyWith(blocks: blocks));
  }

  void clusterNumber() {
    final List<Block> blocks = List.from(state.blocks);
    final currentBlockIndex = state.currentBlockIndex;
    final List<House> houses = List.from(blocks[currentBlockIndex].houses);
    int clusterNumber = 0;
  }

  Future toggleInfected(int index) async {
    final List<Block> blocks = List.from(state.blocks);
    final currentBlockIndex = state.currentBlockIndex;
    final currentBlock = blocks[currentBlockIndex];
    final List<House> houses = List.from(currentBlock.houses);
    final house = houses[index];
    //print(list);
    print(house);
    final houseToggle = house.copyWith(infected: house.infected ? false : true);
    houses.replaceRange(index, index + 1, [houseToggle]);
    final newBLock = currentBlock.copyWith(houses: houses);
    blocks.replaceRange(currentBlockIndex, currentBlockIndex + 1, [newBLock]);
    var json = newBLock.toJson();
    json["clusters"] = [];
    await FirebaseFirestore.instance
        .collection(blockCollection)
        .doc(newBLock.docId)
        .set(json);
    emit(state.copyWith(blocks: blocks));
    toggleCluster(index);
  }

  void toggleCluster(int i) {
    final List<Block> blocks = List.from(state.blocks);
    final currentBlockIndex = state.currentBlockIndex;
    final currentBlock = blocks[currentBlockIndex];
    final List<House> houses = List.from(currentBlock.houses);
    final List<House> checkedHouses = [];
    final Set<House> notCheckedHouse = {};
    notCheckedHouse.add(houses[i]);
    int count = 0;
    print(notCheckedHouse.contains(houses[i]));
    while (notCheckedHouse.isNotEmpty) {
      final house = notCheckedHouse.first;
      final index = house.id - 1;
      final houseTopLeft =
          (index - 10 - 1) >= 0 ? houses[index - 10 - 1] : null;
      final houseTopRight =
          (index - 10 + 1) >= 0 ? houses[index - 10 + 1] : null;
      final houseTop = (index - 10) >= 0 ? houses[index - 10] : null;
      final houseLeft = (index - 1) >= 0 ? houses[index - 1] : null;
      final houseRight = (index + 1) < houses.length ? houses[index + 1] : null;
      final houseBottomLeft =
          (index + 10 - 1) < houses.length ? houses[index + 10 - 1] : null;
      final houseBottomRight =
          (index + 10 + 1) < houses.length ? houses[index + 10 + 1] : null;
      final houseBottom =
          (index + 10) < houses.length ? houses[index + 10] : null;
      if (house.infected) {
        if ((index + 1) % 10 == 0) {
          if (houseBottomLeft?.infected ?? false) {
            if (checkedHouses.contains(houseBottomLeft)) {
            } else {
              if (houseBottomLeft != null) {
                count = count + 1;
                notCheckedHouse.add(houseBottomLeft);
              }
            }
          }
          if (houseLeft?.infected ?? false) {
            if (checkedHouses.contains(houseLeft)) {
            } else {
              if (houseLeft != null) {
                count = count + 1;
                notCheckedHouse.add(houseLeft);
              }
            }
          }
          if (houseTopLeft?.infected ?? false) {
            if (checkedHouses.contains(houseTopLeft)) {
            } else {
              if (houseTopLeft != null) {
                count = count + 1;
                notCheckedHouse.add(houseTopLeft);
              }
            }
          }
          if (houseTop?.infected ?? false) {
            if (checkedHouses.contains(houseTop)) {
            } else {
              if (houseTop != null) {
                count = count + 1;
                notCheckedHouse.add(houseTop);
              }
            }
          }
          if (houseBottom?.infected ?? false) {
            if (checkedHouses.contains(houseBottom)) {
            } else {
              if (houseBottom != null) {
                count = count + 1;
                notCheckedHouse.add(houseBottom);
              }
            }
          }
        } else if ((index + 1) % 10 == 1) {
          if (houseBottomRight?.infected ?? false) {
            if (checkedHouses.contains(houseBottomRight)) {
            } else {
              if (houseBottomRight != null) {
                count = count + 1;
                notCheckedHouse.add(houseBottomRight);
              }
            }
          }
          if (houseRight?.infected ?? false) {
            if (checkedHouses.contains(houseRight)) {
            } else {
              if (houseRight != null) {
                count = count + 1;
                notCheckedHouse.add(houseRight);
              }
            }
          }
          if (houseTopRight?.infected ?? false) {
            if (checkedHouses.contains(houseTopRight)) {
            } else {
              if (houseTopRight != null) {
                count = count + 1;
                notCheckedHouse.add(houseTopRight);
              }
            }
          }
          if (houseTop?.infected ?? false) {
            if (checkedHouses.contains(houseTop)) {
            } else {
              if (houseTop != null) {
                count = count + 1;
                notCheckedHouse.add(houseTop);
              }
            }
          }
          if (houseBottom?.infected ?? false) {
            if (checkedHouses.contains(houseBottom)) {
            } else {
              if (houseBottom != null) {
                count = count + 1;
                notCheckedHouse.add(houseBottom);
              }
              print(houseBottom);
            }
          }
        } else {
          if (houseTopLeft?.infected ?? false) {
            if (checkedHouses.contains(houseTopLeft)) {
            } else {
              if (houseTopLeft != null) {
                count = count + 1;
                notCheckedHouse.add(houseTopLeft);
              }
            }
          }

          if (houseTop?.infected ?? false) {
            if (checkedHouses.contains(houseTop)) {
            } else {
              if (houseTop != null) {
                count = count + 1;
                notCheckedHouse.add(houseTop);
              }
            }
          }
          if (houseTopRight?.infected ?? false) {
            if (checkedHouses.contains(houseTopRight)) {
            } else {
              if (houseTopRight != null) {
                count = count + 1;
                notCheckedHouse.add(houseTopRight);
              }
            }
          }
          if (houseLeft?.infected ?? false) {
            if (checkedHouses.contains(houseLeft)) {
            } else {
              if (houseLeft != null) {
                count = count + 1;
                notCheckedHouse.add(houseLeft);
              }
            }
          }
          if (houseRight?.infected ?? false) {
            if (checkedHouses.contains(houseRight)) {
            } else {
              if (houseRight != null) {
                count = count + 1;
                notCheckedHouse.add(houseRight);
              }
            }
          }
          if (houseBottomLeft?.infected ?? false) {
            if (checkedHouses.contains(houseBottomLeft)) {
            } else {
              if (houseBottomLeft != null) {
                count = count + 1;
                notCheckedHouse.add(houseBottomLeft);
              }
            }
          }
          if (houseBottomRight?.infected ?? false) {
            if (checkedHouses.contains(houseBottomRight)) {
            } else {
              if (houseBottomRight != null) {
                count = count + 1;
                notCheckedHouse.add(houseBottomRight);
              }
            }
          }
          if (houseBottom?.infected ?? false) {
            if (checkedHouses.contains(houseBottom)) {
            } else {
              if (houseBottom != null) {
                count = count + 1;
                notCheckedHouse.add(houseBottom);
              }
            }
          }
        }
      } else {
        print("Not Infected");
      }
      notCheckedHouse.remove(house);
      checkedHouses.add(house);
      // print(notCheckedHouse);
      // print(checkedHouses);
    }

    totalCluster();
  }

  void totalCluster() {
    final List<Block> blocks = List.from(state.blocks);
    final currentBlockIndex = state.currentBlockIndex;
    final currentBlock = blocks[currentBlockIndex];
    final List<House> houses = List.from(currentBlock.houses);
    final Set<House> checkedHouses = {};
    Set<House> temp = {};
    Set<House> tempList = {};
    final List<List<House>> clusters = [];

    //final Set<House> newCheckedHouse = {};
    int count = 0;
    houses.forEach((element) {
      final Set<House> notCheckedHouse = {};
      if (element.infected == true && !checkedHouses.contains(element)) {
        notCheckedHouse.add(element);
        while (notCheckedHouse.isNotEmpty) {
          final house = notCheckedHouse.first;
          final index = house.id - 1;
          final houseTopLeft =
              (index - 10 - 1) >= 0 ? houses[index - 10 - 1] : null;
          final houseTopRight =
              (index - 10 + 1) >= 0 ? houses[index - 10 + 1] : null;
          final houseTop = (index - 10) >= 0 ? houses[index - 10] : null;
          final houseLeft = (index - 1) >= 0 ? houses[index - 1] : null;
          final houseRight =
              (index + 1) < houses.length ? houses[index + 1] : null;
          final houseBottomLeft =
              (index + 10 - 1) < houses.length ? houses[index + 10 - 1] : null;
          final houseBottomRight =
              (index + 10 + 1) < houses.length ? houses[index + 10 + 1] : null;
          final houseBottom =
              (index + 10) < houses.length ? houses[index + 10] : null;
          if (house.infected) {
            if ((index + 1) % 10 == 0) {
              if (houseBottomLeft?.infected ?? false) {
                if (checkedHouses.contains(houseBottomLeft)) {
                } else {
                  if (houseBottomLeft != null) {
                    notCheckedHouse.add(houseBottomLeft);
                  }
                }
              }
              if (houseLeft?.infected ?? false) {
                if (checkedHouses.contains(houseLeft)) {
                } else {
                  if (houseLeft != null) {
                    notCheckedHouse.add(houseLeft);
                  }
                }
              }
              if (houseTopLeft?.infected ?? false) {
                if (checkedHouses.contains(houseTopLeft)) {
                } else {
                  if (houseTopLeft != null) {
                    notCheckedHouse.add(houseTopLeft);
                  }
                }
              }
              if (houseTop?.infected ?? false) {
                if (checkedHouses.contains(houseTop)) {
                } else {
                  if (houseTop != null) {
                    notCheckedHouse.add(houseTop);
                  }
                }
              }
              if (houseBottom?.infected ?? false) {
                if (checkedHouses.contains(houseBottom)) {
                } else {
                  if (houseBottom != null) {
                    notCheckedHouse.add(houseBottom);
                  }
                }
              }
            } else if ((index + 1) % 10 == 1) {
              if (houseBottomRight?.infected ?? false) {
                if (checkedHouses.contains(houseBottomRight)) {
                } else {
                  if (houseBottomRight != null) {
                    notCheckedHouse.add(houseBottomRight);
                  }
                }
              }
              if (houseRight?.infected ?? false) {
                if (checkedHouses.contains(houseRight)) {
                } else {
                  if (houseRight != null) {
                    notCheckedHouse.add(houseRight);
                  }
                }
              }
              if (houseTopRight?.infected ?? false) {
                if (checkedHouses.contains(houseTopRight)) {
                } else {
                  if (houseTopRight != null) {
                    notCheckedHouse.add(houseTopRight);
                  }
                }
              }
              if (houseTop?.infected ?? false) {
                if (checkedHouses.contains(houseTop)) {
                } else {
                  if (houseTop != null) {
                    notCheckedHouse.add(houseTop);
                  }
                }
              }
              if (houseBottom?.infected ?? false) {
                if (checkedHouses.contains(houseBottom)) {
                } else {
                  if (houseBottom != null) {
                    notCheckedHouse.add(houseBottom);
                  }
                  print(houseBottom);
                }
              }
            } else {
              if (houseTopLeft?.infected ?? false) {
                if (checkedHouses.contains(houseTopLeft)) {
                } else {
                  if (houseTopLeft != null) {
                    notCheckedHouse.add(houseTopLeft);
                  }
                }
              }

              if (houseTop?.infected ?? false) {
                if (checkedHouses.contains(houseTop)) {
                } else {
                  if (houseTop != null) {
                    notCheckedHouse.add(houseTop);
                  }
                }
              }
              if (houseTopRight?.infected ?? false) {
                if (checkedHouses.contains(houseTopRight)) {
                } else {
                  if (houseTopRight != null) {
                    notCheckedHouse.add(houseTopRight);
                  }
                }
              }
              if (houseLeft?.infected ?? false) {
                if (checkedHouses.contains(houseLeft)) {
                } else {
                  if (houseLeft != null) {
                    notCheckedHouse.add(houseLeft);
                  }
                }
              }
              if (houseRight?.infected ?? false) {
                if (checkedHouses.contains(houseRight)) {
                } else {
                  if (houseRight != null) {
                    notCheckedHouse.add(houseRight);
                  }
                }
              }
              if (houseBottomLeft?.infected ?? false) {
                if (checkedHouses.contains(houseBottomLeft)) {
                } else {
                  if (houseBottomLeft != null) {
                    notCheckedHouse.add(houseBottomLeft);
                  }
                }
              }
              if (houseBottomRight?.infected ?? false) {
                if (checkedHouses.contains(houseBottomRight)) {
                } else {
                  if (houseBottomRight != null) {
                    notCheckedHouse.add(houseBottomRight);
                  }
                }
              }
              if (houseBottom?.infected ?? false) {
                if (checkedHouses.contains(houseBottom)) {
                } else {
                  if (houseBottom != null) {
                    notCheckedHouse.add(houseBottom);
                  }
                }
              }
            }
          } else {
            print("Not Infected");
          }
          notCheckedHouse.remove(house);
          checkedHouses.add(house);
          //print(notCheckedHouse);print
          print("fjfkjfjgkjhkjgdh");
          print(checkedHouses);
        }
        print("/////////////////");
        print(checkedHouses.length);
        // int? index;
        // state.blocks[currentBlockIndex].clusters
        //     .asMap()
        //     .forEach((index, cluster) {
        //   if (checkedHouses.forEach((element) {})) ;
        // });
        temp = Set.from(checkedHouses);
        temp.removeAll(tempList);
        tempList = Set.from(checkedHouses);
        count = count + 1;
        //newCheckedHouse.addAll(checkedHouses);
        clusters.add(temp.toList());
      }
    });
    print(clusters.length);
    print(clusters);
    print('Count');
    print(count);
    final newBlock =
        currentBlock.copyWith(clusterCount: count, clusters: clusters);
    blocks.replaceRange(currentBlockIndex, currentBlockIndex + 1, [newBlock]);
    emit(state.copyWith(blocks: blocks));
  }
}
