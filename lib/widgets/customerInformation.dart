import 'package:bike_zone/models/clientModel.dart';
import 'package:bike_zone/viewModels/clientsViewModel.dart';
import 'package:bike_zone/viewModels/components/appLocal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jiffy/jiffy.dart';

class CustomerInformation extends StatelessWidget {
  final String? id;
  CustomerInformation({Key? key, this.id}) : super(key: key);
  ClientViewModel _clientViewModel = ClientViewModel();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ClientModel>(
        future: _clientViewModel.readDataById(id.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Card(
              margin: EdgeInsets.all(10),
              child: (Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${getLang(context, "customer number")}",
                      ),
                      Text("${getLang(context, "customer name")} "),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 50),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          " ${snapshot.data!.phoneNumber}",
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 30),
                        height: 40,
                        width: 150,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text("${snapshot.data!.name}"),
                        decoration: BoxDecoration(border: Border.all()),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Text(
                          "${getLang(context, "customer id")} ",
                        ),
                      ),
                      Container(
                          child:
                              Text("${getLang(context, "number of visits")} ")),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 40,
                        margin: EdgeInsets.only(left: 50),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "${snapshot.data!.id}",
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 40,
                        child: Text(
                          "${snapshot.data!.howManyVisits}",
                        ),
                        margin: EdgeInsets.only(right: 50),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text("${getLang(context, "customer visit date")} "),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(border: Border.all()),
                      height: 35,
                      width: 130,
                      child: Text(
                          "${Jiffy(snapshot.data!.time).format("y/M/d")}")),
                ],
              )),
            );
          }
          return Center(child: Text("Loading .../"));
        });
  }
}
