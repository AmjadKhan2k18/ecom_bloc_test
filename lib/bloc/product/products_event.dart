part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class InitProducts extends ProductsEvent {
  final List<Product> products;

  const InitProducts({this.products = const <Product>[]});

  @override
  List<Object> get props => products;
}

class LoadingProducts extends ProductsEvent {}

class SearchProducts extends ProductsEvent {
  final List<Product> products;

  const SearchProducts({this.products = const <Product>[]});

  @override
  List<Object> get props => [products];
}

class LoadMoreProducts extends ProductsEvent {
  final List<Product> products;

  const LoadMoreProducts({required this.products});

  @override
  List<Product> get props => products;
}
