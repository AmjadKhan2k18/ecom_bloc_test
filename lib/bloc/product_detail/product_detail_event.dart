part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class GetProductDetail extends ProductDetailEvent {
  final String productId;

  const GetProductDetail(this.productId);
}
