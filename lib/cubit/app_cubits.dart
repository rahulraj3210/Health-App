import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_app/models/house.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_app/screens/homepage.dart';
part 'app_cubits.freezed.dart';
part 'app_states.dart';

class AppCubits extends Cubit<CubitState> {
  AppCubits() : super(CubitState()) {
    emit(state.copyWith(houses: [
      House(id: 1, infected: false),
    ]));
    init();
  }
  Stream<List<House>> readhouse() => FirebaseFirestore.instance
      .collection('House_list')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => House.fromJson(doc.data()).copyWith(docId: doc.id))
          .toList());
  void init() {
    readhouse().listen((housee) {
      housee.sort((a, b) => a.id.compareTo(b.id));
      emit(state.copyWith(houses: housee));
      totalCluster();
    });
  }

  Future addHouse() async {
    final List<House> list = List.from(state.houses);
    final doc = FirebaseFirestore.instance.collection("House_list").doc();
    final newHouse = House(id: list.last.id + 1, docId: doc.id);
    list.add(newHouse);
    await FirebaseFirestore.instance
        .collection("House_list")
        .doc(newHouse.docId)
        .set(newHouse.toJson());
    emit(state.copyWith(houses: list));
  }

  Future removeHouse() async {
    final List<House> list = List.from(state.houses);
    final house = list.last;
    list.removeLast();
    await FirebaseFirestore.instance
        .collection("House_list")
        .doc(house.docId)
        .delete();
    emit(state.copyWith(houses: list));
  }

  Future toggleInfected(int index) async {
    final List<House> list = List.from(state.houses);
    final house = list[index];
    //print(list);
    print(house);
    final houseToggle = house.copyWith(infected: house.infected ? false : true);
    list.replaceRange(index, index + 1, [houseToggle]);
    await FirebaseFirestore.instance
        .collection("House_list")
        .doc(houseToggle.docId)
        .set(houseToggle.toJson());
    emit(state.copyWith(houses: list));
    toggleCluster(index);
  }

  void toggleCluster(int i) {
    final List<House> houses = List.from(state.houses);
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
      print(notCheckedHouse);
      print(checkedHouses);
    }
    print(checkedHouses.length);
    totalCluster();
  }

  void totalCluster() {
    final List<House> houses = List.from(state.houses);
    final Set<House> checkedHouses = {};
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
          //print(notCheckedHouse);
          //print(checkedHouses);
        }
        count = count + 1;
        //newCheckedHouse.addAll(checkedHouses);
      }
    });
    print('Count');
    print(count);
    emit(state.copyWith(totalCluster: count));
  }
}
