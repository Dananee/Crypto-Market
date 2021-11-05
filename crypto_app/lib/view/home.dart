import 'package:crypto_coins_news_app/controller/povider.dart';
import 'package:crypto_coins_news_app/controller/geting_data.dart';
import 'package:crypto_coins_news_app/controller/setting_page.dart';
import 'package:crypto_coins_news_app/view/list_tile.dart';
import 'package:crypto_coins_news_app/controller/povider.dart';
import 'package:crypto_coins_news_app/controller/search_bar.dart';
import 'package:crypto_coins_news_app/view/offline_page.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:crypto_coins_news_app/model/model.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String search = 'bitcoin';

  bool select = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GetData().getChart();
    return Consumer<ThemeModes>(builder: (context, notify, child) {
      var isconnected = Provider.of<DataConnectionStatus>(context);
      if (isconnected == DataConnectionStatus.connected) {
        return SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  elevation: 0.0,
                  title: Text('Crypto Coin Market News'),
                  centerTitle: false,
                  actions: [
                    IconButton(
                        onPressed: () {
                          showSearch(context: context, delegate: DataSearch());
                        },
                        icon: Icon(Icons.search)),
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.cog,
                        size: 20.0,
                      ),
                      onPressed: () => Get.to(SettingsPage()),
                    ),
                  ],
                ),
                body: Center(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: StreamBuilder<List<Model>>(
                      stream: Stream.periodic(Duration(seconds: 1))
                          .asyncMap((i) => GetData().getData()),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Model> data = snapshot.data;
                          return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListOfTile(
                                  isSparck: true,
                                  sparkLink: data[index].sparckLink,
                                  title: data[index].id,
                                  price: data[index].price,
                                  image: data[index].image,
                                  capital: data[index].capital,
                                );
                              });
                        } else if (snapshot.hasError) {
                          print('${snapshot.error}');
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                )));
      }
      return Scaffold(body: Offline());
    });
  }
}
