class ProductDetail {
  String id;
  String title;
  double price;
  String currencyId;
  List<Pictures> pictures;
  String? description;
  int? onAdded;

  ProductDetail({
    required this.id,
    required this.title,
    required this.price,
    required this.currencyId,
    required this.pictures,
    required this.description,
    this.onAdded,
  });

  factory ProductDetail.fromJson({
    required Map<String, dynamic> productJson,
    required Map<String, dynamic>? descriptionJson,
  }) {
    List<Pictures> _pictures = [];

    productJson['pictures'].forEach((v) {
      _pictures.add(Pictures.fromJson(v));
    });

    return ProductDetail(
      id: productJson['id'],
      title: productJson['title'],
      price: double.parse(productJson['price'].toString()),
      currencyId: productJson['currency_id'],
      pictures: _pictures,
      description: descriptionJson?['plain_text'],
    );
  }
  factory ProductDetail.fromDetailProductJson(
    Map<String, dynamic> productJson,
  ) {
    List<Pictures> _pictures = [];
    final tempList = productJson['pictures'].split('|');
    tempList.forEach((url) => _pictures.add(Pictures(url: url)));

    return ProductDetail(
        id: productJson['id'],
        title: productJson['title'],
        price: double.parse(productJson['price'].toString()),
        currencyId: productJson['currency_id'],
        pictures: _pictures,
        description: productJson['description'],
        onAdded: productJson['onAdded']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['currency_id'] = currencyId;
    data['pictures'] = pictures.map((v) => v.url).toList().join('|');
    data['description'] = description;
    data['onAdded'] = DateTime.now().millisecondsSinceEpoch;
    return data;
  }
}

class Pictures {
  String url;

  Pictures({required this.url});

  factory Pictures.fromJson(Map<String, dynamic> json) {
    return Pictures(url: json['url']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['url'] = url;
    return data;
  }
}
