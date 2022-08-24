import 'package:bike_zone/models/clientModel.dart';
import 'package:bike_zone/viewModels/clientsViewModel.dart';
import 'package:bike_zone/viewModels/components/appLocal.dart';
import 'package:bike_zone/views/agreementScreenWidget.dart';
import 'package:bike_zone/views/showDataWidget.dart';
import 'package:bike_zone/widgets/customerInformation.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class CustomerDetails extends StatefulWidget {
  final String? id;
  final String? name;
  final String? phoneNumber;

  CustomerDetails({
    Key? key,
    this.id,
    this.name,
    this.phoneNumber,
  }) : super(key: key);

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  ClientViewModel _clientViewModel = ClientViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            heroTag: null,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AgreementScreenWidget(
                  customer_Name: "${widget.name}",
                  customer_id: "${widget.id}",
                  customer_PhoneNumber: "${widget.phoneNumber}",
                ),
              ));
            },
            child: Icon(Icons.add)),
        backgroundColor: Colors.blue[400],
        appBar: AppBar(
            title: Text(
              "${getLang(context, "customer details")}",
              textAlign: TextAlign.center,
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("showData");
                },
                icon: Icon(Icons.arrow_back))),
        body: CustomerInformation(
          id: "${widget.id}",
        ));
  }
}
