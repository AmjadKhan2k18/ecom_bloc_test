part of 'products_history_bloc.dart';

abstract class RecentProductsEvent extends Equatable {
  const RecentProductsEvent();

  @override
  List<Object> get props => [];
}

class LoadRecentProducts extends RecentProductsEvent {}

class AddNewProduct extends RecentProductsEvent {
  final ProductDetail product;

  const AddNewProduct(this.product);
}
