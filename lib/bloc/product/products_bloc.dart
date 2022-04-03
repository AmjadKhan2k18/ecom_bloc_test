import 'package:bloc/bloc.dart';
import 'package:ecommerce_bloc/models/product.dart';
import 'package:ecommerce_bloc/services/api_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  String searchValue = '';
  ScrollController scrollController = ScrollController();
  ProductsBloc() : super(ProductsInitial()) {
    on<SearchProducts>(_onSearchProducts);
    on<LoadMoreProducts>(_onLoadMoreProducts);
  }

  void _onSearchProducts(
    SearchProducts event,
    Emitter<ProductsState> emit,
  ) async {
    try {
      emit(ProductsSearching());
      final products = await ApiProvider.fetchProducts(search: searchValue);
      emit(ProductsLoaded(products: products));
    } catch (e) {
      emit(ProductsErrorState());
    }
  }

  void _onLoadMoreProducts(
    LoadMoreProducts event,
    Emitter<ProductsState> emit,
  ) async {
    try {
      List<Product> allProducts = event.products;
      emit(ProductsLoadingMore(products: allProducts));

      final newProducts = await ApiProvider.fetchProducts(
        search: searchValue,
        offset: event.products.length,
      );
      allProducts.addAll(newProducts);
      emit(ProductsLoaded(products: allProducts));
    } catch (e) {
      emit(ProductsErrorState());
    }
  }
}
