import 'package:bloc/bloc.dart';

import 'package:ecommerce_bloc/models/country.dart';
import 'package:ecommerce_bloc/services/api_provider.dart';
import 'package:equatable/equatable.dart';

part 'countries_event.dart';
part 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  Country? selectedCountry;
  List<Country> countries = [];

  CountriesBloc() : super(CountriesInitial()) {
    on<LoadCountries>(_onLoadCountries);
    on<SelectCountry>(_onSelectCountry);
    on<UpdateCountry>(_onUpdateCountry);
  }

  void _onLoadCountries(
      LoadCountries event, Emitter<CountriesState> emit) async {
    try {
      emit(CountriesLoading());
      final _countries = await ApiProvider.fetchCountries();
      countries = _countries;
      emit(CountriesLoaded(countries: _countries));
    } catch (e) {
      emit(CountryErrorState());
    }
  }

  void _onSelectCountry(
      SelectCountry event, Emitter<CountriesState> emit) async {
    selectedCountry = event.country;
    emit(CountrySelected());
  }

  void _onUpdateCountry(UpdateCountry event, Emitter<CountriesState> emit) {
    emit(CountryUpdate());
  }
}
