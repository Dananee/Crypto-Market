import 'package:flutter/material.dart';

class ConfigurePage extends StatefulWidget {
  @override
  _ConfigurePageState createState() => _ConfigurePageState();
}

class _ConfigurePageState extends State<ConfigurePage> {
  Settings settings;

  List<Settings> st;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: DefaultTextStyle(
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.w300, color: Colors.grey),
        softWrap: true,
        textAlign: TextAlign.start,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
              itemCount: _settings.length,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: Theme.of(context).cardColor,
                  title: Text(
                    _settings[index].title,
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w400),
                  ),
                  leading: Icon(
                    _settings[index].icon,
                    size: 30.0,
                  ),
                  onTap: _settings[index].function,
                );
              }),
        ),
      ),
    );
  }
}

class Settings {
  final String title;
  final Function function;
  final IconData icon;

  Settings({this.function, this.icon, this.title});
}

final List<Settings> _settings = <Settings>[
  Settings(
      function: () {
        print('Dark mode');
      },
      icon: Icons.lightbulb,
      title: 'Dark Mode'),
  Settings(
      function: () {
        print('Units');
      },
      icon: Icons.money,
      title: 'Units'),
];
