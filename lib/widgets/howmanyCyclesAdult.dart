import 'package:bike_zone/providers/howManyCyclesSelected.dart';
import 'package:bike_zone/viewModels/components/appLocal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HowManyCyclesAdult extends StatefulWidget {
  HowManyCyclesAdult({Key? key}) : super(key: key);

  @override
  State<HowManyCyclesAdult> createState() => _HowManyCyclesAdultState();
}

class _HowManyCyclesAdultState extends State<HowManyCyclesAdult> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1)),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        children: [
          Text(
            "${getLang(context, "how many adult bicycle")} ",
            style: TextStyle(fontSize: 15),
          ),
          Consumer<HowManyCycleSelectedAdult>(
            builder: (context, provider, child) => DropdownButton(
              items: [0, 1, 2, 3, 4, 5, 6]
                  .map((e) => DropdownMenuItem(
                        child: Text("$e"),
                        value: e,
                      ))
                  .toList(),
              onChanged: (val) {
                provider.selectedAdultCycles(val);
              },
              value: provider.countAdultCycles,
            ),
          ),
        ],
      ),
    );
  }
}
