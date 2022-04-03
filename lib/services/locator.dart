import 'package:ecommerce_bloc/bloc/countries/countries_bloc.dart';
import 'package:ecommerce_bloc/bloc/currency/currency_bloc.dart';
import 'package:ecommerce_bloc/bloc/product/products_bloc.dart';
import 'package:ecommerce_bloc/bloc/product_detail/product_detail_bloc.dart';
import 'package:ecommerce_bloc/bloc/products_history/products_history_bloc.dart';
import 'package:ecommerce_bloc/services/local_db.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setUpLocator() {
  serviceLocator.registerSingleton<ProductsBloc>(
    ProductsBloc(),
  );
  serviceLocator.registerSingleton<CountriesBloc>(
    CountriesBloc()
      ..add(
        LoadCountries(),
      ),
  );
  serviceLocator.registerSingleton<ProductDetailBloc>(
    ProductDetailBloc(),
  );
  serviceLocator.registerSingleton<CurrencyBloc>(
    CurrencyBloc()..add(LoadCurrencies()),
  );
  serviceLocator.registerSingleton<RecentProductsBloc>(
    RecentProductsBloc()..add(LoadRecentProducts()),
  );
  serviceLocator.registerSingleton<DatabaseHelper>(DatabaseHelper());
}
