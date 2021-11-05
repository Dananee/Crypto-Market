import 'package:crypto_coins_news_app/controller/geting_data.dart';
import 'package:crypto_coins_news_app/controller/povider.dart';
import 'package:crypto_coins_news_app/model/chart_data.dart';
import 'package:crypto_coins_news_app/model/money_format.dart';
import 'package:crypto_coins_news_app/view/chart_graph.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final double price;
  final double mrkp;
  final String image;
  final List sparkLink;

  DetailPage({this.image, this.mrkp, this.price, this.title, this.sparkLink});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _currency = Get.put(SaveCurrency());

  List<ChartModel> _chartdata;

  @override
  void initState() {
    super.initState();
    // _chartdata = getChartData();
    GetData().getChart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.toUpperCase()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40.0,
              backgroundImage: NetworkImage(widget.image),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              widget.title.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Price : ' +
                  ' ' +
                  MoneyFormat.detailed.format(widget.price).toString() +
                  ' ' +
                  _currency.getMoney?.toUpperCase(),
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Market Capital : ' +
                  ' ' +
                  MoneyFormat.detailed.format(widget.mrkp).toString() +
                  ' ' +
                  _currency.getMoney?.toUpperCase(),
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            // ChartGraph(),
            //
            // Container(
            //     height: MediaQuery.of(context).size.height * .25,
            //     width: MediaQuery.of(context).size.width,
            //     child: SfCartesianChart(
            //       series: <ChartSeries>[
            //         LineSeries<ChartModel, dynamic>(
            //           dataSource: _chartdata,
            //           xValueMapper: (ChartModel chartModel, _) =>
            //               chartModel.dates,
            //           yValueMapper: (ChartModel chartModel, _) =>
            //               chartModel.prices,
            //         )
            //       ],
            //     )),
          ],
        ),
      ),
    );
  }
}
