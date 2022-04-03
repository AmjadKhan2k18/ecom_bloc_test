part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Product> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsSearching extends ProductsState {}

class ProductsLoadingMore extends ProductsState {
  final List<Product> products;

  const ProductsLoadingMore({required this.products});

  @override
  List<Product> get props => products;
}

class ProductsLoaded extends ProductsState {
  final List<Product> products;

  const ProductsLoaded({required this.products});

  @override
  List<Product> get props => products;
}

class ProductsErrorState extends ProductsState {}
