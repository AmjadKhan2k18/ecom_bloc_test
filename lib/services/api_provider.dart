import 'package:ecommerce_bloc/bloc/countries/countries_bloc.dart';
import 'package:ecommerce_bloc/models/country.dart';
import 'package:ecommerce_bloc/models/currency.dart';
import 'package:ecommerce_bloc/models/product.dart';
import 'package:ecommerce_bloc/models/product_detail.dart';
import 'package:ecommerce_bloc/services/http_requests.dart';
import 'package:ecommerce_bloc/services/locator.dart';

class ApiProvider {
  static Future<List<Currency>> fetchCurrencies() async {
    List<Currency> currencies = [];

    final responseBody = await HttpRequest.get(endUrl: 'currencies');
    responseBody.forEach(
      (currency) => currencies.add(Currency.fromJson(currency)),
    );
    return currencies;
  }

  static Future<List<Country>> fetchCountries() async {
    List<Country> countries = [];

    final responseBody = await HttpRequest.get(endUrl: 'sites');
    responseBody.forEach(
      (country) => countries.add(Country.fromJson(country)),
    );
    return countries;
  }

  static Future<List<Product>> fetchProducts({
    required String search,
    int offset = 0,
  }) async {
    List<Product> products = [];

    final responseBody = await HttpRequest.get(
        endUrl:
            'sites/${serviceLocator.get<CountriesBloc>().selectedCountry!.id}/search?q=$search&limit=20&offset=$offset');
    responseBody['results'].forEach(
      (product) => products.add(Product.fromJson(product)),
    );
    return products;
  }

  static Future<ProductDetail> fetchProductDetail(String productId) async {
    late dynamic productJson;
    Map<String, dynamic>? descriptionJson;

    await Future.wait([
      (() async =>
          productJson = await HttpRequest.get(endUrl: 'items/$productId'))(),
      (() async => descriptionJson =
          await HttpRequest.get(endUrl: 'items/$productId/description'))(),
    ]);

    ProductDetail productDetail = ProductDetail.fromJson(
      productJson: productJson,
      descriptionJson: descriptionJson,
    );
    return productDetail;
  }
}
