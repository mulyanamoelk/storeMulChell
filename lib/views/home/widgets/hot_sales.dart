import 'package:elektroku/components/item_product.dart';
import 'package:elektroku/controllers/item_bag_controller.dart';
import 'package:elektroku/controllers/product_controller.dart';
import 'package:elektroku/models/product_model.dart';
import 'package:elektroku/views/detail_product/detail_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HotSalesProduct extends ConsumerWidget {
  final int getIndex;
  const HotSalesProduct({super.key, required this.getIndex});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productNotifierProvider);
    return SizedBox(
      height: 275.0,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailProduct(getIndex: index),
                ),
              );
            },
            child: ItemProduct(
              icon: const Icon(Icons.add_circle),
              onPressed: () {
                ref
                    .read(productNotifierProvider.notifier)
                    .isSelectItem(product[index].id, index);
                if (product[getIndex].isSelected == false) {
                  ref.read(itemBagProvider.notifier).addNewItemBg(
                        ProductModel(
                            id: product[getIndex].id,
                            imgUrl: product[getIndex].imgUrl,
                            title: product[getIndex].title,
                            price: product[getIndex].price,
                            shortDescription:
                                product[getIndex].shortDescription,
                            longDescription: product[getIndex].longDescription,
                            review: product[getIndex].review,
                            rating: product[getIndex].rating),
                      );
                } else {
                  ref
                      .read(itemBagProvider.notifier)
                      .removeItem(product[getIndex].id);
                }
              },
              image: product[index].imgUrl,
              title: product[index].title,
              shortDescription: product[index].shortDescription,
              price: product[index].price,
            ),
          );
        },
      ),
    );
  }
}
