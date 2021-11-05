import 'dart:async';
import 'package:crypto_coins_news_app/controller/connection_check.dart';
import 'package:crypto_coins_news_app/controller/geting_data.dart';
import 'package:crypto_coins_news_app/controller/povider.dart';
import 'package:crypto_coins_news_app/controller/povider.dart';
import 'package:crypto_coins_news_app/controller/setting_page.dart';
import 'package:crypto_coins_news_app/view/home.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SaveCurrency().initPref();
  runApp(ChangeNotifierProvider<ThemeModes>(
      create: (_) => ThemeModes(), child: CryptoApp()));
}

class CryptoApp extends StatefulWidget {
  @override
  _CryptoAppState createState() => _CryptoAppState();
}

class _CryptoAppState extends State<CryptoApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModes>(builder: (context, value, child) {
      return StreamProvider<DataConnectionStatus>(
        create: (_) {
          return DataConnectvityServer().dataConnectionStatus.stream;
        },
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: Colors.amber),
          themeMode: value.themeModes ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData.dark(),
          home: Home(),
        ),
      );
    });
  }
}
