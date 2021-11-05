import 'package:crypto_coins_news_app/controller/geting_data.dart';
import 'package:crypto_coins_news_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class ChartGraph extends StatefulWidget {
  @override
  _ChartGraphState createState() => _ChartGraphState();
}

class _ChartGraphState extends State<ChartGraph> {
  List<double> dataChart(List<Model> datas) {
    List<double> elm = [];
    datas.forEach((element) {
      elm = element.sparckLink.map((e) => e as double).toList();
    });
    return elm;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        height: MediaQuery.of(context).size.height * .2,
        color: Colors.blueGrey,
        child: FutureBuilder<List<Model>>(
          future: GetData().getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return Sparkline(
                data: dataChart(data),
                pointsMode: PointsMode.last,
                pointSize: 2.0,
                lineWidth: 1,
              );
            } else if (snapshot.hasError) {
              print(snapshot.error.toString());
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
