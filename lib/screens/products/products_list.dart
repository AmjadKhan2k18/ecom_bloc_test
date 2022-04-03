import 'package:ecommerce_bloc/bloc/product/products_bloc.dart';
import 'package:ecommerce_bloc/screens/products/single_product.dart';
import 'package:ecommerce_bloc/services/locator.dart';
import 'package:ecommerce_bloc/widgets/nothing_to_show.dart';
import 'package:flutter/material.dart';

class ProductsListView extends StatefulWidget {
  const ProductsListView({Key? key}) : super(key: key);

  @override
  State<ProductsListView> createState() => _ProductsListViewState();
}

class _ProductsListViewState extends State<ProductsListView> {
  late ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    final productsBloc = serviceLocator.get<ProductsBloc>();
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      productsBloc.add(LoadMoreProducts(products: productsBloc.state.props));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsBloc = serviceLocator.get<ProductsBloc>();
    return StreamBuilder<ProductsState>(
      stream: productsBloc.stream,
      builder: (context, snapshot) {
        return productsBloc.state.props.isEmpty
            ? const NothingToShow('No Products Found, Please search again')
            : ListView.builder(
                controller: _controller,
                itemCount: productsBloc.state.props.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProductView(product: productsBloc.state.props[index]);
                },
              );
      },
    );
  }
}
