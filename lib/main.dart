import 'package:bike_zone/providers/howManyCyclesSelected.dart';
import 'package:bike_zone/providers/rentDuration.dart';
import 'package:bike_zone/providers/totalPrace.dart';
import 'package:bike_zone/viewModels/components/appLocal.dart';
import 'package:bike_zone/views/agreementScreenWidget.dart';
import 'package:bike_zone/views/currentRenters.dart';
import 'package:bike_zone/views/customerDetails.dart';
import 'package:bike_zone/views/mainScreenWidget.dart';
import 'package:bike_zone/views/showDataWidget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TotalPrice(),
        ),
        ChangeNotifierProvider(
          create: (context) => HowManyCycleSelectedAdult(),
        ),
        ChangeNotifierProvider(
          create: (context) => HowManyCycleSelectedKidz(),
        ),
        ChangeNotifierProvider(
          create: (context) => RentDuration(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          locale: _locale,
          localizationsDelegates: [
            AppLocale.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [Locale("en", "US"), Locale("ar", "SA")],
          localeResolutionCallback: (currentLang, supportLang) {
            if (currentLang != null) {
              for (Locale locale in supportLang) {
                if (locale.languageCode == currentLang.languageCode) {
                  return currentLang;
                }
              }
            }
            return supportLang.first;
          },
          routes: {
            "agrementScreen": (context) => AgreementScreenWidget(),
            "showData": (context) => ShowData(),
            "mainScreen": (context) => MainScreenWidget(),
            "cutomerDetails": (context) => CustomerDetails(),
            "currentRenter": (context) => CurrentRentrs()
          },
          home: MainScreenWidget()),
    );
  }
}
