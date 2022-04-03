part of 'countries_bloc.dart';

abstract class CountriesEvent extends Equatable {
  const CountriesEvent();

  @override
  List<Object> get props => [];
}

class LoadCountries extends CountriesEvent {
  @override
  List<Country> get props => [];
}

class UpdateCountry extends CountriesEvent {
  final List<Country> countries;

  const UpdateCountry(this.countries);
  @override
  List<Country> get props => countries;
}

class LoadedCountries extends CountriesEvent {
  final List<Country> countries;

  const LoadedCountries(this.countries);
  @override
  List<Country> get props => countries;
}

class SelectCountry extends CountriesEvent {
  final Country country;
  const SelectCountry(this.country);
}
