import 'package:bloc/bloc.dart';
import 'package:ecommerce_bloc/models/product_detail.dart';
import 'package:ecommerce_bloc/services/local_db.dart';
import 'package:ecommerce_bloc/services/locator.dart';
import 'package:equatable/equatable.dart';

part 'products_history_event.dart';
part 'products_history_state.dart';

class RecentProductsBloc
    extends Bloc<RecentProductsEvent, RecentProductsState> {
  Map<String, ProductDetail> recentProducts = {};
  RecentProductsBloc() : super(RecentProductsInitial()) {
    on<LoadRecentProducts>(_onLoadRecentProducts);
    on<AddNewProduct>(_onAddNewProduct);
  }

  void _onLoadRecentProducts(
    LoadRecentProducts event,
    Emitter<RecentProductsState> emit,
  ) async {
    await _getProducts();
    emit(RecentProductsLoaded(recentProducts));
  }

  _onAddNewProduct(
    AddNewProduct event,
    Emitter<RecentProductsState> emit,
  ) async {
    final _dbHelper = serviceLocator.get<DatabaseHelper>();
    final isInRecents = recentProducts.containsKey(event.product.id);
    //if products is already in recent products then update product which will udpate onAdded too
    if (isInRecents) {
      return _dbHelper.updateProduct(event.product);
    } else {
      // if stored products length is 5 then delete product which is stored first
      // I am using onAdded to find which was stored first
      if (recentProducts.length == 5) {
        int oldestTimeStamp = DateTime.now().millisecondsSinceEpoch;
        late String olderProductId;
        for (var product in recentProducts.values) {
          if (product.onAdded! < oldestTimeStamp) {
            oldestTimeStamp = product.onAdded!;
            olderProductId = product.id;
          }
        }
        _dbHelper.deleteProduct(olderProductId);
      }
      // I am storing Product Object instead of reference to avoid request for API's for each when app open
      // I could store just product ID and request to API's on open app
      await _dbHelper.insertProduct(event.product);
    }

    // everytime we store new recent product, get products again to have latest recents products
    await _getProducts();
    emit(RecentProductsLoaded(recentProducts));
  }

  Future<Map<String, ProductDetail>> _getProducts() async {
    recentProducts = {};
    final products =
        await serviceLocator.get<DatabaseHelper>().getProductsList();
    for (var product in products) {
      recentProducts[product.id] = product;
    }
    return recentProducts;
  }
}
