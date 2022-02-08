import 'package:crypto_coins_news_app/controller/geting_data.dart';
import 'package:crypto_coins_news_app/view/list_tile.dart';
import 'package:crypto_coins_news_app/model/model.dart';
import 'package:crypto_coins_news_app/view/offline_page.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:provider/provider.dart';

class DataSearch extends SearchDelegate {
  final bool connection;
  final List<Model> m;
  DataSearch({this.m, this.connection});
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            semanticLabel: 'Not Found',
            height: MediaQuery.of(context).size.height * .5,
            width: MediaQuery.of(context).size.width * .8,
            image: Svg('assets/images/no_data.svg'),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Not Found',
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var _isconnected = Provider.of<DataConnectionStatus>(context);
    if (_isconnected == DataConnectionStatus.connected) {
      return FutureBuilder(
          future: GetData().getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Model> data = snapshot.data;

              var searchList = query.isEmpty
                  ? data
                  : data
                      .where((element) =>
                          element.id.startsWith(query.toLowerCase()))
                      .toList();
              if (searchList.length > 0) {
                return ListView.builder(
                  itemCount: searchList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListOfTile(
                      isSparck: false,
                      title: searchList[index].id,
                      image: searchList[index].image,
                      price: searchList[index].price,
                      capital: searchList[index].capital,
                      sparkLink: [],
                    );
                  },
                );
              } else if (searchList.length == 0) {
                return Image(
                  height: MediaQuery.of(context).size.height * .5,
                  width: MediaQuery.of(context).size.width * .8,
                  image: Svg('assets/images/no_data.svg'),
                );
              }
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          });
    }
    return Scaffold(body: Offline());
  }
}
