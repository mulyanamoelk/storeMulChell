import 'package:elektroku/controllers/item_bag_controller.dart';
import 'package:elektroku/controllers/product_controller.dart';
import 'package:elektroku/models/product_model.dart';
import 'package:elektroku/shared/constants/themes.dart';
import 'package:elektroku/shared/extentions/money.dart';
import 'package:elektroku/views/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailProduct extends ConsumerWidget {
  final int getIndex;
  const DetailProduct({super.key, required this.getIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productNotifierProvider);
    final price = product[getIndex].price;
    final qty = product[getIndex].qty;
    final totalprice = price * qty!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 24.0,
            color: whiteColor,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Product Details",
          style: ThemesFonts.Font22WhiteBold,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.local_mall,
              size: 24.0,
              color: whiteColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300.0,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                product[getIndex].imgUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product[getIndex].title,
                    style: const TextStyle(
                      fontSize: 22.0,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      RatingBar(
                        glowColor: Colors.yellow,
                        initialRating: 3,
                        itemSize: 25.0,
                        minRating: 1,
                        maxRating: 5,
                        allowHalfRating: true,
                        ratingWidget: RatingWidget(
                          full: const Icon(
                            Icons.star,
                            size: 24.0,
                          ),
                          half: const Icon(
                            Icons.star_half_sharp,
                            size: 24.0,
                          ),
                          empty: const Icon(
                            Icons.star_border,
                            size: 24.0,
                          ),
                        ),
                        onRatingUpdate: (value) {},
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "123 reviews",
                          style: TextStyle(
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    product[getIndex].longDescription,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    totalprice.formatRupiah(),
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          ref
                              .read(productNotifierProvider.notifier)
                              .decrement(productItem[getIndex].id);
                        },
                        child: const Icon(
                          Icons.remove_circle_outline,
                          size: 24.0,
                          color: blackColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          product[getIndex].qty.toString(),
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          ref
                              .read(productNotifierProvider.notifier)
                              .increment(product[getIndex].id);
                        },
                        child: const Icon(
                          Icons.add_circle_outline,
                          size: 24.0,
                          color: blackColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            InkWell(
              onTap: () {
                ref
                    .read(productNotifierProvider.notifier)
                    .isSelectItem(product[getIndex].id, getIndex);
                if (product[getIndex].isSelected == false) {
                  ref.read(itemBagProvider.notifier).addNewItemBg(
                        ProductModel(
                          id: product[getIndex].id,
                          imgUrl: product[getIndex].imgUrl,
                          title: product[getIndex].title,
                          price: product[getIndex].price,
                          shortDescription: product[getIndex].shortDescription,
                          longDescription: product[getIndex].longDescription,
                          review: product[getIndex].review,
                          rating: product[getIndex].rating,
                          qty: product[getIndex].qty,
                        ),
                      );
                } else {
                  ref
                      .read(itemBagProvider.notifier)
                      .removeItem(product[getIndex].id);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24.0),
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Add Item to Bag",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
