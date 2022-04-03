import 'package:ecommerce_bloc/bloc/countries/countries_bloc.dart';
import 'package:ecommerce_bloc/services/locator.dart';
import 'package:ecommerce_bloc/screens/countries_screen.dart';
import 'package:ecommerce_bloc/screens/products/products_screen.dart';
import 'package:flutter/material.dart';

void main() {
  setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final countriesState = serviceLocator.get<CountriesBloc>();
    return StreamBuilder<CountriesState>(
        stream: countriesState.stream,
        builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: const Color(0xFFBBDEFB),
            ),
            home: countriesState.selectedCountry == null
                ? const CountriesScreen()
                : ProductsScreen(),
          );
        });
  }
}
