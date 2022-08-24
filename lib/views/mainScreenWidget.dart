import 'package:bike_zone/main.dart';
import 'package:bike_zone/models/languages.dart';
import 'package:bike_zone/viewModels/components/appLocal.dart';
import 'package:flutter/material.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  void _changeLanguage(Language language) async {
    Locale _temp;
    switch (language.languageCode) {
      case 'ar':
        _temp = Locale(language.languageCode, "SA");
        break;
      case 'en':
        _temp = Locale(language.languageCode, "US");
        break;
      default:
        _temp = Locale(language.languageCode, "SA");
    }
    MyApp.setLocale(context, _temp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<Language>(
              underline: SizedBox(),
              icon: Icon(
                Icons.language,
                color: Colors.white,
              ),
              onChanged: (Language? language) {
                _changeLanguage(language!);
              },
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                      value: e,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            e.flag,
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(e.name)
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.blue[400],
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 6,
              childAspectRatio: 1,
              crossAxisSpacing: 6,
            ),
            children: [
              InkWell(
                  onTap: (() {
                    Navigator.of(context).pushNamed("agrementScreen");
                  }),
                  child: Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            border: Border.all(
                              color: Colors.white,
                              width: 5,
                            )),
                        child: Image.asset(
                          "images/makeRent.jpg",
                          width: 250,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${getLang(context, "create rent agrement")} ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )),
              InkWell(
                  onTap: (() {
                    Navigator.of(context).pushNamed("showData");
                  }),
                  child: Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Container(
                          height: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Icon(
                            Icons.group,
                            size: 100,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${getLang(context, "show customers")} ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )),
              InkWell(
                  onTap: (() {
                    Navigator.of(context).pushNamed("currentRenter");
                  }),
                  child: Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            border: Border.all(
                              color: Colors.white,
                              width: 5,
                            )),
                        child: Image.asset(
                          "images/byCycl.jpg",
                          height: 50,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${getLang(context, "current renters")} ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textDirection: TextDirection.ltr),
                      ),
                    ],
                  )),
            ]),
      ),
    );
  }
}
