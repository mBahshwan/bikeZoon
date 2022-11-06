import 'package:bike_zone/models/clientModel.dart';
import 'package:bike_zone/repository/repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientViewModel {
  ClientModel clientModel = ClientModel();
  static CollectionReference renterRef =
      FirebaseFirestore.instance.collection("renters");

  @override
  Future<List<ClientModel>> readData() async {
    QuerySnapshot response = await renterRef.get();
    return response.docs.map((e) => ClientModel.fromFirebase(e)).toList();
  }

  static Future<List<ClientModel>> getClientToSearchByNumber(
      String query) async {
    QuerySnapshot response = await renterRef.get();

    return response.docs
        .map((e) => ClientModel.fromFirebase(e))
        .where((element) {
      String studentname = element.phoneNumber.toString();
      String querySearch = query.toLowerCase();
      return studentname.contains(querySearch);
    }).toList();
  }

  static Future<List<ClientModel>> getClientToSearchById(String query) async {
    QuerySnapshot response = await renterRef.get();

    return response.docs
        .map((e) => ClientModel.fromFirebase(e))
        .where((element) {
      String studentname = element.id.toString();
      String querySearch = query.toLowerCase();
      return studentname.contains(querySearch);
    }).toList();
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
