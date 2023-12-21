import 'package:bikeshop/Constants/appColors.dart';
import 'package:bikeshop/Service/firebaseServiceMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetails extends StatefulWidget {
  final dynamic product;
  const ProductDetails({super.key, this.product});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColors.kPrimaryColor,
            child: IconButton(
                onPressed: () => Navigator.pop(
                      context,
                    ),
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.white,
                )),
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        widget.product['product-img'],
                      ),
                      fit: BoxFit.cover)),
            ),
            Text(
              widget.product['product-name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Text(widget.product['product-description']),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "\u{20B9} ${widget.product['product-price'].toString()}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: AppColors.kPrimaryColor,
              ),
            ),
            const Divider(),
            SizedBox(
              width: 1.sw,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () {
                  FirebaseServiceManager()
                      .addToCart(
                    product: widget.product,
                    context: context,
                  )
                      .then((value) {
                    FirebaseServiceManager().setCartNumber(
                      collectionName: "users-cart-items",
                      context: context,
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kPrimaryColor,
                  elevation: 3,
                ),
                child: Text(
                  "Add to cart",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
