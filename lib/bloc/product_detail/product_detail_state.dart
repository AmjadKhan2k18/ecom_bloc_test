part of 'product_detail_bloc.dart';

abstract class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object> get props => [];
}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailErrorState extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final ProductDetail productDetail;

  const ProductDetailLoaded(this.productDetail);
  @override
  List<Object> get props => [productDetail];
}
