import 'package:intl/intl.dart';

class MoneyFormat {
  static var detailed = NumberFormat("####,#####.#######", "en_US");
  static var home = NumberFormat("##,###.####", "en_US");
}
