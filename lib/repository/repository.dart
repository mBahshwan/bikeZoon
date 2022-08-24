import 'package:bike_zone/models/clientModel.dart';

abstract class Repository {
  Future<List<ClientModel>> readData();
  Future<void> addData(String name, int id, DateTime time, int phoneNumber,
      String duration, int kidzCycles, int adultCycles, int howManyVisits);
  Future<void> deleteData();
}
