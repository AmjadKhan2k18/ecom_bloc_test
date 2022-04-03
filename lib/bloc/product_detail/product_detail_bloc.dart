import 'package:bloc/bloc.dart';
import 'package:ecommerce_bloc/bloc/products_history/products_history_bloc.dart';
import 'package:ecommerce_bloc/models/product_detail.dart';
import 'package:ecommerce_bloc/services/api_provider.dart';
import 'package:ecommerce_bloc/services/locator.dart';
import 'package:equatable/equatable.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitial()) {
    on<GetProductDetail>(_onGetProductDetail);
  }

  void _onGetProductDetail(
    GetProductDetail event,
    Emitter<ProductDetailState> emit,
  ) async {
    try {
      emit(ProductDetailLoading());
      final product = await ApiProvider.fetchProductDetail(event.productId);
      emit(ProductDetailLoaded(product));
      serviceLocator.get<RecentProductsBloc>().add(AddNewProduct(product));
    } catch (e) {
      emit(ProductDetailErrorState());
    }
  }
}
