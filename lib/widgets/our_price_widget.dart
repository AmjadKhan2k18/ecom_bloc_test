import 'package:ecommerce_bloc/bloc/currency/currency_bloc.dart';
import 'package:ecommerce_bloc/services/locator.dart';
import 'package:flutter/material.dart';

class OurPriceView extends StatelessWidget {
  final String currencyId;
  final int price;
  final double fontSize;
  const OurPriceView({
    Key? key,
    required this.currencyId,
    required this.price,
    this.fontSize = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyBloc = serviceLocator.get<CurrencyBloc>();
    return Text(
      '${currencyBloc.getCurrencySymbol(currencyId)} $price',
      style: TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        fontSize: fontSize,
      ),
    );
  }
}
