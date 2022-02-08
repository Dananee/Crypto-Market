import 'dart:convert';
import 'package:crypto_coins_news_app/controller/povider.dart';
import 'package:crypto_coins_news_app/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class GetData extends GetxController {
  final _currency = Get.put(SaveCurrency());

  List<dynamic> chartdata = [];

  Future<List<Model>> getData() async {
    Map<String, dynamic> quriesParam = {
      'vs_currency': _currency.getMoney ?? 'usd',
      'order': 'market_cap_desc',
      'per_page': '100',
      'page': '1',
      'sparkline': 'true'
    };

    update();
    Uri url =
        Uri.https('api.coingecko.com', '/api/v3/coins/markets', quriesParam);

    http.Response response =
        await http.get(url, headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      List body = json.decode(response.body) as List;

      List<Model> dataModel =
          body.map((item) => new Model.fromJson(item)).toList();

      return dataModel;
    } else {
      print('${response.statusCode}');
    }
  }

  Future<List<dynamic>> getChart() async {
    Uri url = Uri.parse(
        'https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=usd&days=7');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var data = body['prices'];

      for (var d in data) {
        chartdata.add(d);
      }

      return chartdata;
    }
  }
}
