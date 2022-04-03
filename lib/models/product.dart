import 'package:ecommerce_bloc/bloc/countries/countries_bloc.dart';
import 'package:ecommerce_bloc/services/locator.dart';

class Product {
  String id;
  String title;
  double price;
  String currencyId;
  String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.currencyId,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        // currencyId is nullable if it's null then we get it from selectedCountry
        currencyId: json['currency_id'] ??
            serviceLocator
                .get<CountriesBloc>()
                .selectedCountry!
                .defaultCurrencyId,
        price: double.parse(json['price'].toString()),
        thumbnail: json['thumbnail'],
        title: json['title'],
      );
}
