import 'package:cloud_firestore/cloud_firestore.dart';

class ClientModel {
  String? name;
  String? id;
  DateTime? time;
  String? phoneNumber;
  var howManyVisits;

  ClientModel(
      {this.name, this.id, this.time, this.phoneNumber, this.howManyVisits});
  factory ClientModel.fromFirebase(DocumentSnapshot data) {
    return ClientModel(
        name: (data.data() as dynamic)['name'],
        id: (data.data() as dynamic)['id'],
        time: ((data.data() as dynamic)['time'] as Timestamp).toDate(),
        phoneNumber: (data.data() as dynamic)['phone_number'],
        howManyVisits: (data.data() as dynamic)['how_many_visits']);
  }
  Map<String, dynamic> toFirebase() => {
        "name": name,
        "id": id,
        "time": time,
        "phone_number": phoneNumber,
        "how_many_visits": howManyVisits
      };
}
