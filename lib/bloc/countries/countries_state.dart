part of 'countries_bloc.dart';

abstract class CountriesState extends Equatable {
  const CountriesState();

  @override
  List<Country> get props => [];
}

class CountriesInitial extends CountriesState {}

class CountriesLoading extends CountriesState {}

class CountrySelected extends CountriesState {}

class CountryUpdate extends CountriesState {}

class CountryErrorState extends CountriesState {}

class CountriesLoaded extends CountriesState {
  final List<Country> countries;

  const CountriesLoaded({required this.countries});

  @override
  List<Country> get props => countries;
}
