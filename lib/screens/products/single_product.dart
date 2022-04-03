import 'package:ecommerce_bloc/bloc/product_detail/product_detail_bloc.dart';
import 'package:ecommerce_bloc/models/product.dart';
import 'package:ecommerce_bloc/screens/product_detail_screen.dart';
import 'package:ecommerce_bloc/services/locator.dart';
import 'package:ecommerce_bloc/widgets/our_price_widget.dart';
import 'package:flutter/material.dart';

class ProductView extends StatelessWidget {
  final Product product;
  const ProductView({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        serviceLocator.get<ProductDetailBloc>().add(
              GetProductDetail(product.id),
            );

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const ProductDetailScreen(),
          ),
        );
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              product.thumbnail,
            ),
          ),
          title: Text(
            product.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Container(
            width: 70,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: OurPriceView(
              currencyId: product.currencyId,
              price: product.price.ceil(),
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
