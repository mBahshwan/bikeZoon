import 'package:bike_zone/models/currentRentersModel.dart';
import 'package:bike_zone/viewModels/components/appLocal.dart';
import 'package:bike_zone/viewModels/currentRentersViewModel.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class CurrentRentrs extends StatefulWidget {
  const CurrentRentrs({Key? key}) : super(key: key);

  @override
  State<CurrentRentrs> createState() => _CurrentRentrsState();
}

class _CurrentRentrsState extends State<CurrentRentrs> {
  CurrentRentersViewModel _currentRentersViewModel = CurrentRentersViewModel();

  bool timeUp = false;
  String? customerComingTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          centerTitle: true,
          title: Text("${getLang(context, "current renters")} "),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back))),
      body: FutureBuilder<List<CurrentRentersModel>>(
        future: _currentRentersViewModel.readData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, i) {
                customerComingTime =
                    "${Jiffy("${snapshot.data![i].time}").fromNow()}";

                return Container(
                  height: 250,
                  width: 300,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("${getLang(context, "customer number")}"),
                            Text("${getLang(context, "customer name")}")
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.all(6),
                                decoration:
                                    BoxDecoration(border: Border.all(width: 1)),
                                child:
                                    Text("${snapshot.data![i].phoneNumber}")),
                            Container(
                                padding: EdgeInsets.all(6),
                                decoration:
                                    BoxDecoration(border: Border.all(width: 1)),
                                child: Text("${snapshot.data![i].name}")),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.all(6),
                                decoration:
                                    BoxDecoration(border: Border.all(width: 1)),
                                child: Text(
                                    "${snapshot.data![i].kidzCycles} : ${getLang(context, "how many kidz bicycle")} ")),
                            Container(
                                padding: EdgeInsets.all(6),
                                decoration:
                                    BoxDecoration(border: Border.all(width: 1)),
                                child: Text(
                                    "${snapshot.data![i].adlutCycles}  : ${getLang(context, "how many adult bicycle")} ")),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            content: Text(
                                              "${getLang(context, "sure delete")}",
                                            ),
                                            title: Text(
                                                "  ${getLang(context, "delete note1")}  ${snapshot.data![i].name}  ${getLang(context, "delete note2")} ${snapshot.data![i].phoneNumber}",
                                                style: TextStyle(fontSize: 13)),
                                            actions: [
                                              IconButton(
                                                  onPressed: () async {
                                                    await _currentRentersViewModel
                                                        .deleteData(snapshot
                                                            .data![i].id
                                                            .toString());
                                                    Navigator.of(context)
                                                        .pushNamedAndRemoveUntil(
                                                            "currentRenter",
                                                            (route) => false);
                                                  },
                                                  icon: Icon(Icons.delete)),
                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  icon: Icon(
                                                    Icons.cancel,
                                                  ))
                                            ],
                                          ));
                                },
                                icon: Icon(Icons.circle,
                                    size: 20,
                                    color: customerComingTime == 'an hour ago'
                                        ? Colors.red
                                        : Colors.blue)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("${getLang(context, "rent duration")}"),
                            Text("${getLang(context, "customer login time")} ")
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.all(6),
                                decoration:
                                    BoxDecoration(border: Border.all(width: 1)),
                                child: Text("${snapshot.data![i].duration}")),
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration:
                                  BoxDecoration(border: Border.all(width: 1)),
                              alignment: Alignment.center,
                              height: 30,
                              width: 90,
                              child: Text("${customerComingTime}"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
