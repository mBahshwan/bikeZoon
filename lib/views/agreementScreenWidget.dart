import 'package:bike_zone/models/clientModel.dart';
import 'package:bike_zone/models/conditionAndTerms.dart';
import 'package:bike_zone/models/currentRentersModel.dart';
import 'package:bike_zone/providers/howManyCyclesSelected.dart';
import 'package:bike_zone/providers/rentDuration.dart';
import 'package:bike_zone/providers/totalPrace.dart';
import 'package:bike_zone/viewModels/clientsViewModel.dart';
import 'package:bike_zone/viewModels/components/appLocal.dart';
import 'package:bike_zone/viewModels/currentRentersViewModel.dart';
import 'package:bike_zone/widgets/SignHere.dart';
import 'package:bike_zone/widgets/howLongCycle.dart';
import 'package:bike_zone/widgets/howManyCyclesKidz.dart';
import 'package:bike_zone/widgets/howmanyCyclesAdult.dart';
import 'package:bike_zone/widgets/textforminformation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AgreementScreenWidget extends StatefulWidget {
  final String? customer_Name;
  final String? customer_PhoneNumber;
  final String? customer_id;

  AgreementScreenWidget(
      {this.customer_Name,
      this.customer_PhoneNumber,
      this.customer_id,
      Key? key})
      : super(key: key);

  @override
  State<AgreementScreenWidget> createState() => _AgreementScreenWidgetState();
}

class _AgreementScreenWidgetState extends State<AgreementScreenWidget> {
  Conditions conditions = Conditions();

  TextEditingController customerName = TextEditingController();

  TextEditingController customerId = TextEditingController();

  TextEditingController customerPhoneNumber = TextEditingController();

  @override
  void initState() {
    customerName.text = widget.customer_Name ?? "";
    customerPhoneNumber.text = widget.customer_PhoneNumber ?? "";
    customerId.text = widget.customer_id ?? "";
    super.initState();
  }

  deletSignature() {
    signatureController.clear();
  }

  ClientViewModel clientViewModel = ClientViewModel();
  CurrentRentersViewModel currentRentersViewModel = CurrentRentersViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            color: Colors.white,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Container(
              margin: const EdgeInsets.only(top: 25),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  alignment: Alignment.centerLeft,
                  height: 60,
                  width: 130,
                  child: Image.asset("images/logo.jpeg"),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    "${getLang(context, "rent agreement")} ",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          width: 100,
                          decoration:
                              BoxDecoration(border: Border.all(width: 1)),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: TypeAheadField<ClientModel>(
                            textFieldConfiguration: TextFieldConfiguration(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                controller: customerPhoneNumber,
                                decoration: InputDecoration(
                                    hintText:
                                        "${getLang(context, "customer number")} ",
                                    border: OutlineInputBorder())),
                            suggestionsCallback:
                                ClientViewModel.getClientToSearchByNumber,
                            itemBuilder: (context, itemData) => ListTile(
                                title: Text(itemData.phoneNumber.toString())),
                            onSuggestionSelected: (suggestion) {
                              customerName.text = suggestion.name!;
                              customerId.text = suggestion.id!;
                              customerPhoneNumber.text =
                                  suggestion.phoneNumber!;
                            },
                            hideOnEmpty: true,
                          ),
                        )),
                    const SizedBox(width: 10),
                    TextFormInfo(
                      infoType: "${getLang(context, "customer name")} ",
                      keybordType: TextInputType.name,
                      controller: customerName,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HowLongCycle(),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          width: 100,
                          decoration:
                              BoxDecoration(border: Border.all(width: 1)),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: TypeAheadField<ClientModel>(
                            textFieldConfiguration: TextFieldConfiguration(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                controller: customerId,
                                decoration: InputDecoration(
                                    hintText:
                                        "${getLang(context, "customer id")} ",
                                    border: OutlineInputBorder())),
                            suggestionsCallback:
                                ClientViewModel.getClientToSearchById,
                            itemBuilder: (context, itemData) =>
                                ListTile(title: Text(itemData.id.toString())),
                            onSuggestionSelected: (suggestion) {
                              customerName.text = suggestion.name!;
                              customerId.text = suggestion.id!;
                              customerPhoneNumber.text =
                                  suggestion.phoneNumber!;
                            },
                            hideOnEmpty: true,
                          ),
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(child: HowManyCyclesAdult(), width: 170),
                        SizedBox(child: HowManyCyclesKidz(), width: 170),
                      ]),
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("${getLang(context, "price")} :"),
                      Text("${getLang(context, "price")} :"),
                    ]),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Consumer<TotalPrice>(
                        builder: (context, val, child) => TextField(
                          onChanged: (value) {
                            try {
                              val.adultPrice = int.parse(value);
                            } on FormatException {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)))),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Form(
                          child: Consumer<TotalPrice>(
                        builder: (context, val, child) => TextFormField(
                          onChanged: ((value) {
                            try {
                              val.kidzPrice = int.parse(value);
                            } on FormatException {
                              return null;
                            }
                          }),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)))),
                        ),
                      )),
                    ),
                  ],
                ),
                Consumer<TotalPrice>(
                  builder: (context, val, child) => ListTile(
                      title: MaterialButton(
                          child: Text("${getLang(context, "total")} "),
                          onPressed: () {
                            val.getTotal();
                          }),
                      leading: Container(
                        height: 60,
                        width: 120,
                        alignment: Alignment.center,
                        child: Container(
                            height: 60,
                            width: 120,
                            alignment: Alignment.center,
                            decoration:
                                BoxDecoration(border: Border.all(width: 1)),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                                "${val.totalPrice} ${getLang(context, "rial")} ")),
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 364,
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                        vertical: BorderSide(width: 1),
                        horizontal: BorderSide(width: 1)),
                  ),
                  child: ListView(
                    children: [
                      Container(
                          child: Text(
                        "الشروط والاحكام",
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: conditions.conInAr.length,
                        itemBuilder: (context, i) => Container(
                          margin: EdgeInsets.all(20),
                          child: Text("${conditions.conInAr[i]}",
                              textDirection: TextDirection.rtl),
                        ),
                      ),
                      Divider(),
                      Container(
                          child: Text(
                        "Terms & Condition",
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                      ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: conditions.conInEn.length,
                          itemBuilder: (context, i) => Container(
                                margin: EdgeInsets.all(20),
                                child: Text("${conditions.conInEn[i]}",
                                    textDirection: TextDirection.rtl),
                              )),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 30,
                            child: Text("signature : ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: 80,
                              width: 130,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 1)),
                              child: SignHere(),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            height: 30,
                            child: Text(" : التوقيع",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                deletSignature();
                              },
                              child: Text("clear")),
                          SizedBox(
                            width: 30,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                dynamic rentDuration =
                                    context.read<RentDuration>().howLong;
                                ClientModel clientModel = ClientModel(
                                    name: customerName.text,
                                    id: customerId.text,
                                    phoneNumber: customerPhoneNumber.text,
                                    howManyVisits: FieldValue.increment(1),
                                    time: DateTime.now());

                                CurrentRentersModel currentRentersModel =
                                    CurrentRentersModel(
                                  name: customerName.text,
                                  id: customerId.text,
                                  duration: rentDuration,
                                  phoneNumber: customerPhoneNumber.text,
                                  time: DateTime.now(),
                                  kidzCycles: context
                                      .read<HowManyCycleSelectedKidz>()
                                      .countKidzCycles,
                                  adlutCycles: context
                                      .read<HowManyCycleSelectedAdult>()
                                      .countAdultCycles,
                                );

                                await clientViewModel.addData(
                                    "${clientModel.id}",
                                    clientModel.toFirebase());

                                await currentRentersViewModel.addData(
                                    "${currentRentersModel.id}",
                                    currentRentersModel.toFirebase());

                                await deletSignature();

                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    "showData", (route) => false);
                              },
                              child: Text("save "))
                        ],
                      )
                    ],
                  ),
                )
              ]),
            )),
      ),
    );
  }
}
