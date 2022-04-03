import 'package:ecommerce_bloc/bloc/countries/countries_bloc.dart';
import 'package:ecommerce_bloc/services/locator.dart';
import 'package:ecommerce_bloc/widgets/nothing_to_show.dart';
import 'package:ecommerce_bloc/widgets/our_loading.dart';
import 'package:flutter/material.dart';

class CountriesScreen extends StatelessWidget {
  final bool isUpdate;
  const CountriesScreen({Key? key, this.isUpdate = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countriesbloc = serviceLocator.get<CountriesBloc>();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        color: Theme.of(context).primaryColor,
        height: double.maxFinite,
        width: double.maxFinite,
        alignment: Alignment.center,
        child: StreamBuilder<CountriesState>(
          stream: countriesbloc.stream,
          builder: (context, snapshot) {
            if (countriesbloc.state is CountryErrorState) {
              return const NothingToShow(
                'Something went wrong, Please try again later',
              );
            }
            if (countriesbloc.state is CountriesLoaded ||
                countriesbloc.state is CountryUpdate) {
              return Wrap(
                alignment: WrapAlignment.center,
                children: countriesbloc.countries
                    .map((country) => InkWell(
                          onTap: () {
                            countriesbloc.add(SelectCountry(country));
                            if (isUpdate) Navigator.of(context).pop();
                          },
                          child: Card(
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Text(country.name)),
                          ),
                        ))
                    .toList(),
              );
            }
            return const OurLoading();
          },
        ),
      ),
    );
  }
}
