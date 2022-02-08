import 'package:crypto_coins_news_app/controller/povider.dart';
import 'package:crypto_coins_news_app/model/currencies.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Currency {
  final _controllerCurrency = Get.put(ControllerCurrency());

  String get isCurrency => _controllerCurrency.selectData;
}

class ControllerCurrency extends GetxController {
  var selected = 'usd'.obs;

  // GetStorage box = GetStorage();
  void selectedCurrency(String value) {
    selected.value = value;
  }

  String get selectData => selected.value;
}

class SettingsPage extends StatelessWidget {
  bool value = false;

  List<String> keys = currencies.keys.toList();

  final _currency = Get.put(Currency());

  Widget dropDownMenu(BuildContext context) {
    var _curency = Get.put(Currency());

    return GetX<ControllerCurrency>(builder: (controller) {
      return DropdownButton<String>(
        value: controller.selectData ?? 'usd',
        elevation: 16,
        style: TextStyle(color: Theme.of(context).accentColor),
        underline: Container(
          height: 2,
          color: Theme.of(context).accentColor,
        ),
        onChanged: (String value) {
          controller.selectedCurrency(value);
          SaveCurrency().saveData(_curency.isCurrency);
        },
        items: keys.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value.toUpperCase(),
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
          );
        }).toList(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModes>(builder: (context, notify, _) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Settings'),
            leading: IconButton(
              icon: Icon(FontAwesomeIcons.arrowLeft),
              onPressed: () => Get.back(),
            ),
            centerTitle: true,
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20.0),
            children: [
              ListTile(
                leading: Icon(FontAwesomeIcons.coins),
                title: Text('Change Currency'),
                trailing: dropDownMenu(context),
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.moon),
                title: Text('Dark Mode'),
                trailing: Switch(
                  value: notify.themeModes,
                  onChanged: (bool values) {
                    notify.getMode();
                  },
                ),
              ),
            ],
          ));
    });
  }
}
