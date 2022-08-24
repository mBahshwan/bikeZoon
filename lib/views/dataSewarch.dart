import 'package:bike_zone/models/clientModel.dart';
import 'package:bike_zone/viewModels/clientsViewModel.dart';
import 'package:bike_zone/views/agreementScreenWidget.dart';
import 'package:bike_zone/views/customerDetails.dart';
import 'package:bike_zone/widgets/customerInformation.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<int> {
  String? id;
  String? phoneNumber;
  String? name;
  List<ClientModel>? filterList;
  ClientViewModel _viewModel = ClientViewModel();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          heroTag: null,
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => AgreementScreenWidget(
                    customer_PhoneNumber: phoneNumber,
                    customer_Name: name,
                    customer_id: id,
                  ),
                ),
                (route) => false);
          },
          child: Icon(Icons.add)),
      backgroundColor: Colors.blue[400],
      body: CustomerInformation(
        id: id.toString(),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<ClientModel>>(
        future: _viewModel.readData(),
        builder: (context, snapshot) {
          filterList = snapshot.data
              ?.where((element) =>
                  element.id!.contains(query) ||
                  element.phoneNumber!.contains(query))
              .toList();
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount:
                  query.isEmpty ? snapshot.data!.length : filterList!.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    id = query.isEmpty
                        ? "${snapshot.data![i].id}"
                        : "${filterList![i].id}";
                    phoneNumber = query.isEmpty
                        ? "${snapshot.data![i].phoneNumber}"
                        : "${filterList![i].phoneNumber}";
                    name = query.isEmpty
                        ? "${snapshot.data![i].name}"
                        : "${filterList![i].name}";

                    query = query.isEmpty
                        ? "${snapshot.data![i].name}"
                        : "${filterList![i].name}";

                    showResults(context);
                  },
                  child: ListTile(
                      leading: Icon(Icons.person, color: Colors.black),
                      title: query.isEmpty
                          ? Text("${snapshot.data![i].name}")
                          : Text("${filterList![i].name}")),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
