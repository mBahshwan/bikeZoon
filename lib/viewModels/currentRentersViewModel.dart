import 'package:bike_zone/models/clientModel.dart';
import 'package:bike_zone/models/currentRentersModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentRentersViewModel {
  CurrentRentersModel currentRenters = CurrentRentersModel();
  CollectionReference _renterRef =
      FirebaseFirestore.instance.collection("currentRenters");

  Future<List<CurrentRentersModel>> readData() async {
    QuerySnapshot response = await _renterRef.get();
    return response.docs
        .map((e) => CurrentRentersModel.fromFirebase(e))
        .toList();
  }

  Future<void> addData(String id, Map<String, dynamic> data) async {
    await _renterRef
        .doc("$id")
        .set(data)
        .then((value) => print("Added done"))
        .catchError((e) => print("ERROR : $e"));
  }

  Future<void> deleteData(String id) async {
    await _renterRef.doc("$id").delete().then((value) {
      print("Deleted successfuly");
    }).catchError((e) {
      print("EROOR :$e");
    });
  }
}
