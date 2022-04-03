import 'package:ecommerce_bloc/bloc/products_history/products_history_bloc.dart';
import 'package:ecommerce_bloc/models/product_detail.dart';
import 'package:ecommerce_bloc/services/locator.dart';
import 'package:ecommerce_bloc/widgets/nothing_to_show.dart';
import 'package:ecommerce_bloc/widgets/our_price_widget.dart';
import 'package:flutter/material.dart';

class RecentsScreen extends StatelessWidget {
  const RecentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recentProductsBloc = serviceLocator.get<RecentProductsBloc>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Recents Products'),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: StreamBuilder<RecentProductsState>(
          stream: recentProductsBloc.stream,
          builder: (context, snapshot) {
            final recents = recentProductsBloc.state.props.first
                as Map<String, ProductDetail>;
            return recents.isNotEmpty
                ? RecentsList(recents)
                : const NothingToShow(
                    'In this screen you will find last five viewed products,\nYou have not viewed any product');
          },
        ),
      ),
    );
  }
}

class RecentsList extends StatelessWidget {
  final Map<String, ProductDetail> recents;
  const RecentsList(this.recents, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:
          recents.values.map((value) => SingleProductView(value)).toList(),
    );
  }
}

class SingleProductView extends StatelessWidget {
  final ProductDetail product;
  const SingleProductView(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      child: Stack(
        children: [
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(8),
              ),
              child: OurPriceView(
                currencyId: product.currencyId,
                price: product.price.ceil(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height * 0.05,
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  // color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
      height: height * 0.25,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            product.pictures[0].url,
          ),
        ),
      ),
    );
  }
}
