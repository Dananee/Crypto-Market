class Model {
  String id;
  double price;
  double capital;
  String image;
  List sparckLink;
  Model({this.capital, this.id, this.price, this.image, this.sparckLink});

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      capital: json["market_cap"].toDouble(),
      id: json["id"],
      price: json["current_price"].toDouble(),
      image: json["image"],
      sparckLink: json["sparkline_in_7d"]['price'],
    );
  }
}
