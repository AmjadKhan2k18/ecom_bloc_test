class Currency {
  String id;
  String symbol;
  String description;
  int decimalPlaces;

  Currency({
    required this.id,
    required this.symbol,
    required this.description,
    required this.decimalPlaces,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json['id'],
        symbol: json['symbol'],
        description: json['description'],
        decimalPlaces: json['decimal_places'],
      );
}
