import 'package:bike_zone/models/clientModel.dart';
import 'package:bike_zone/viewModels/clientsViewModel.dart';
import 'package:bike_zone/viewModels/components/appLocal.dart';
import 'package:bike_zone/views/customerDetails.dart';
import 'package:bike_zone/views/dataSewarch.dart';
import 'package:flutter/material.dart';

class ShowData extends StatefulWidget {
  const ShowData({
    Key? key,
  }) : super(key: key);

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  ClientViewModel clientViewModel = ClientViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${getLang(context, "customer list")}"),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    useRootNavigator: true,
                    delegate: DataSearch());
              },
              icon: Icon(Icons.search)),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("mainScreen");
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: FutureBuilder<List<ClientModel>>(
        future: clientViewModel.readData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: ((context, i) => InkWell(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => CustomerDetails(
                                  name: snapshot.data![i].name,
                                  phoneNumber:
                                      "${snapshot.data![i].phoneNumber}",
                                  id: "${snapshot.data![i].id}"),
                            ),
                            (route) => false);
                      },
                      child: ListTile(
                        title: Text("${snapshot.data![i].name}"),
                        subtitle: Text("${snapshot.data![i].id}"),
                        trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        content: Text(
                                            " ${getLang(context, "sure delete")}"),
                                        title: Text(
                                            " ${getLang(context, "delete note1")} ${snapshot.data![i].name}",
                                            style: TextStyle(fontSize: 13)),
                                        actions: [
                                          IconButton(
                                              onPressed: () async {
                                                await clientViewModel.deleteData(
                                                    "${snapshot.data![i].id}");
                                                Navigator.of(context)
                                                    .pushNamedAndRemoveUntil(
                                                        "showData",
                                                        (route) => false);
                                              },
                                              icon: Icon(Icons.delete)),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              icon: Icon(Icons.cancel))
                                        ],
                                      ));
                            },
                            icon: Icon(Icons.delete)),
                      ),
                    )));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
