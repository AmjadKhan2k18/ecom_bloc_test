import 'package:bloc/bloc.dart';
import 'package:ecommerce_bloc/models/currency.dart';
import 'package:ecommerce_bloc/services/api_provider.dart';
import 'package:equatable/equatable.dart';

part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  Map<String, Currency> currenciesMap = {};
  CurrencyBloc() : super(CurrencyInitial()) {
    on<LoadCurrencies>(_onLoadCurrencies);
  }

  String? getCurrencySymbol(String id) => currenciesMap[id]?.symbol;

  void _onLoadCurrencies(
    LoadCurrencies event,
    Emitter<CurrencyState> emit,
  ) async {
    try {
      emit(CurrencyLoading());
      final currencies = await ApiProvider.fetchCurrencies();
      for (var currency in currencies) {
        currenciesMap[currency.id] = currency;
      }
      emit(CurrencyLoaded());
    } catch (e) {
      emit(CurrencyErrorState());
    }
  }
}
