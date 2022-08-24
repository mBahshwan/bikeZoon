import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentRentersModel {
  String? name;
  String? phoneNumber;
  String? duration;
  String? id;
  int? kidzCycles;
  int? adlutCycles;
  DateTime? time;

  CurrentRentersModel(
      {this.name,
      this.phoneNumber,
      this.id,
      this.duration,
      this.adlutCycles,
      this.kidzCycles,
      this.time});

  factory CurrentRentersModel.fromFirebase(DocumentSnapshot data) {
    return CurrentRentersModel(
        name: (data.data() as dynamic)['name'],
        phoneNumber: (data.data() as dynamic)['phone_number'],
        id: (data.data() as dynamic)['id'],
        time: ((data.data() as dynamic)['time'] as Timestamp).toDate(),
        adlutCycles: (data.data() as dynamic)['adult_cycles'],
        duration: (data.data() as dynamic)['duration'],
        kidzCycles: (data.data() as dynamic)['kidz_cycles']);
  }

  Map<String, dynamic> toFirebase() => {
        "name": name,
        "phone_number": phoneNumber,
        "id": id,
        "time": time,
        "adult_cycles": adlutCycles,
        "kidz_cycles": kidzCycles,
        "duration": duration,
      };
}
