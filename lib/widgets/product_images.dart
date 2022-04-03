import 'package:ecommerce_bloc/models/product_detail.dart';
import 'package:flutter/material.dart';

// I Copied this code from github to save sometime
class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductDetail product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.product.id.toString(),
              child: Image.network(
                widget.product.pictures[selectedImage].url,
                // fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ...List.generate(widget.product.pictures.length,
                  (index) => buildSmallProductPreview(index)),
            ],
          ),
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(8),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Theme.of(context)
                  .primaryColor
                  .withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.network(widget.product.pictures[index].url),
      ),
    );
  }
}
