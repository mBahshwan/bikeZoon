import 'package:bike_zone/models/clientModel.dart';
import 'package:bike_zone/repository/repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientViewModel {
  ClientModel clientModel = ClientModel();
  CollectionReference renterRef =
      FirebaseFirestore.instance.collection("renters");

  @override
  Future<List<ClientModel>> readData() async {
    QuerySnapshot response = await renterRef.get();
    return response.docs.map((e) => ClientModel.fromFirebase(e)).toList();
  }

  Future<ClientModel> readDataById(String id) async {
    QuerySnapshot response = await renterRef.get();
    List<ClientModel> list =
        response.docs.map((e) => ClientModel.fromFirebase(e)).toList();
    return list.firstWhere((element) => element.id == id);
  }

  Future<void> addData(String id, Map<String, dynamic> data) async {
    await renterRef
        .doc("$id")
        .set(data, SetOptions(merge: true))
        .then((value) => print("Added done"))
        .catchError((e) => print("ERROR : $e"));
  }

  Future<void> deleteData(String id) async {
    await renterRef.doc(id).delete().then((value) {
      print("Deleted successfuly");
    }).catchError((e) {
      print("EROOR :$e");
    });
  }
}
