import 'package:crypto_coins_news_app/controller/povider.dart';
import 'package:crypto_coins_news_app/controller/setting_page.dart';
import 'package:crypto_coins_news_app/model/money_format.dart';
import 'package:crypto_coins_news_app/view/config_page.dart';
import 'package:crypto_coins_news_app/view/detail-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListOfTile extends StatelessWidget {
  ListOfTile(
      {this.image,
      this.price,
      this.title,
      this.sparkLink,
      this.isSparck,
      this.capital});
  final String title;
  final double price;
  final String image;
  final double capital;
  final List sparkLink;
  final bool isSparck;

  final currency = Get.put(SaveCurrency());
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: isSparck
          ? Container(
              padding: EdgeInsets.all(10.0),
              height: MediaQuery.of(context).size.height * .2,
              width: 150,
              decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: BorderRadius.circular(7.0)),
              child: sparkLink.isEmpty
                  ? Center(child: Text('No Data'))
                  : Sparkline(
                      data: sparkLink.map((e) => e as double).toList(),
                      pointsMode: PointsMode.last,
                      pointSize: 2.0,
                      lineWidth: 1,
                    ),
            )
          : null,
      leading: CircleAvatar(
        radius: 20.0,
        backgroundImage: NetworkImage(image),
      ),
      title: Text(title.toUpperCase()),
      subtitle: Text(MoneyFormat.home.format(price).toString() +
          ' ' +
          currency.getMoney?.toUpperCase()),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return DetailPage(
            title: title ?? 'Unavailable',
            price: price ?? 0.00,
            image: image,
            mrkp: capital ?? 0.00,
          );
        }));
      },
    );
  }
}

Widget graphchart(context, sparkLink) {
  return Padding(
    padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
    child: Container(
      height: MediaQuery.of(context).size.height * .2,
      width: MediaQuery.of(context).size.width * .9,
      decoration: BoxDecoration(
          color: Colors.black38, borderRadius: BorderRadius.circular(13.0)),
      child: Sparkline(
        data: sparkLink.map((e) => e as double).toList(),
        pointsMode: PointsMode.all,
        pointSize: 2.0,
        fillMode: FillMode.below,
        fillColor: Colors.black12,
      ),
    ),
  );
}
