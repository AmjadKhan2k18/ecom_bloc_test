part of 'currency_bloc.dart';

abstract class CurrencyEvent extends Equatable {
  const CurrencyEvent();

  @override
  List<Currency> get props => [];
}

class LoadCurrencies extends CurrencyEvent {}
