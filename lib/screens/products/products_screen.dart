import 'package:ecommerce_bloc/bloc/countries/countries_bloc.dart';
import 'package:ecommerce_bloc/bloc/product/products_bloc.dart';
import 'package:ecommerce_bloc/screens/countries_screen.dart';
import 'package:ecommerce_bloc/screens/products/products_list.dart';
import 'package:ecommerce_bloc/screens/recents_screen.dart';
import 'package:ecommerce_bloc/services/locator.dart';
import 'package:ecommerce_bloc/widgets/nothing_to_show.dart';
import 'package:ecommerce_bloc/widgets/our_loading.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productsBloc = serviceLocator.get<ProductsBloc>();
    final countriesBloc = serviceLocator.get<CountriesBloc>();
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: StreamBuilder<ProductsState>(
          stream: productsBloc.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const NothingToShow('Search for your products');
              // return const OurLoading();
            } else {
              final state = snapshot.data;
              if (state is ProductsSearching) {
                return const OurLoading();
              }
              if (state is ProductsErrorState) {
                return const NothingToShow(
                  'Something went wrong, Please try again later',
                );
              }
              return const ProductsListView();
            }
          },
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      productsBloc.searchValue = searchController.text;
                      productsBloc.add(const SearchProducts());
                    },
                  ),
                  contentPadding: const EdgeInsets.all(12),
                  hintText: 'Search...',
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).primaryColor,
        child: Column(
          children: [
            const SizedBox(height: 100),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                countriesBloc.add(UpdateCountry(countriesBloc.state.props));
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const CountriesScreen(isUpdate: true)));
              },
              leading: const Icon(Icons.flag_circle_rounded),
              title: Text(countriesBloc.selectedCountry!.name),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const RecentsScreen()));
              },
              leading: const Icon(Icons.history_toggle_off),
              title: const Text('Recents'),
            ),
          ],
        ),
      ),
    );
  }
}
