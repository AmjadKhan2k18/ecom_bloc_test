class Country {
  String id;
  String name;
  String defaultCurrencyId;

  Country({
    required this.id,
    required this.name,
    required this.defaultCurrencyId,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json['id'],
        name: json['name'],
        defaultCurrencyId: json['default_currency_id'],
      );
}
