import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:relead/pages/Oops%20Screens/OopsInternet.dart';
import 'package:relead/pages/appScreens/home_page.dart';
import 'package:relead/pages/welcomeScreens/get_started.dart';
import 'package:relead/pages/welcomeScreens/login_page.dart';
import 'package:relead/utils/translation.dart';
import 'package:shared_preferences/shared_preferences.dart';


int? isViewed;
String? token;
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  bool damagedDatabaseDeleted = false;
  await FlutterMapTileCaching.initialise(
    errorHandler: (error) => damagedDatabaseDeleted = false,
    debugMode: true,
  );

  await FMTC.instance.rootDirectory.migrator.fromV6(urlTemplates: []);

  if (prefs.getBool('reset') ?? false) {
    await FMTC.instance.rootDirectory.manage.reset();
  }

  // store creation
  final store = FMTC.instance('storeCazzo');
  await store.manage.createAsync(); // Does nothing if the store already exists.


  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  SharedPreferences preferences = await SharedPreferences.getInstance();
  isViewed = preferences.getInt('StartPage');
  token=preferences.getString('token');

  runApp(MyApp(
      damagedDatabaseDeleted: damagedDatabaseDeleted, store: store));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.damagedDatabaseDeleted, required this.store});

  final bool damagedDatabaseDeleted;
  final StoreDirectory store;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ConnectivityResult result;
  late StreamSubscription subscription;
  var isConnected = false;
  late Widget _loginPage;
  late Widget _startPage;
  late Widget _homePage;

  checkInternet() async {
    result = await Connectivity().checkConnectivity();
    if (result != ConnectivityResult.none) {
      isConnected = true;
    } else {
      isConnected = false;
    }
    setState(() {});
  }

  startStreaming() {
    subscription = Connectivity().onConnectivityChanged.listen((event) async {
      checkInternet();
    });
  }

  @override
  void initState() {
    startStreaming();
    _loginPage=LoginPage(
        damagedDatabaseDeleted: widget.damagedDatabaseDeleted,
        store: widget.store);
    _startPage=StartPage(
        damagedDatabaseDeleted: widget.damagedDatabaseDeleted,
        store: widget.store);
    _homePage=Home(
        damagedDatabaseDeleted: widget.damagedDatabaseDeleted,
        store: widget.store);
    OopsNet();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    //disable rotation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: GetMaterialApp(
          translations: Translation(),
          locale: const Locale(
            'fr',
          ),
          fallbackLocale: const Locale('fr'),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: (Colors.blue)),
          home: isConnected != true
              ? OopsNet()
              :( isViewed != 0 ? _startPage : (token==null? _loginPage : _homePage) ),
        ));
  }
}
