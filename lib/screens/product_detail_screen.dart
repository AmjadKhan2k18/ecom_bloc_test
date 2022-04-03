import 'package:ecommerce_bloc/bloc/product_detail/product_detail_bloc.dart';
import 'package:ecommerce_bloc/models/product_detail.dart';
import 'package:ecommerce_bloc/services/locator.dart';
import 'package:ecommerce_bloc/widgets/nothing_to_show.dart';
import 'package:ecommerce_bloc/widgets/our_loading.dart';
import 'package:ecommerce_bloc/widgets/our_price_widget.dart';
import 'package:ecommerce_bloc/widgets/product_images.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productDetail = serviceLocator.get<ProductDetailBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: StreamBuilder<ProductDetailState>(
          stream: productDetail.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const OurLoading();
            }
            final state = snapshot.data;
            if (state is ProductDetailErrorState) {
              return const NothingToShow(
                'Something went wrong, Please try again later',
              );
            }
            if (state is ProductDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return const ProductDetailBody();
          }),
    );
  }
}

class ProductDetailBody extends StatelessWidget {
  const ProductDetailBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final productDetail = serviceLocator
        .get<ProductDetailBloc>()
        .state
        .props
        .first as ProductDetail;

    return Container(
      padding: const EdgeInsets.only(top: 12),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.5,
              width: double.infinity,
              child: ProductImages(product: productDetail),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            productDetail.title,
                            style: Theme.of(context).textTheme.headline6,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PriceView(productDetail),
                  const Divider(),
                  Text(
                    productDetail.description ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PriceView extends StatelessWidget {
  final ProductDetail productDetail;
  const PriceView(
    this.productDetail, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Price',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        OurPriceView(
          currencyId: productDetail.currencyId,
          price: productDetail.price.ceil(),
        ),
      ],
    );
  }
}
