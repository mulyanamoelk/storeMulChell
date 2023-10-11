import 'package:elektroku/components/item_product.dart';
import 'package:elektroku/controllers/item_bag_controller.dart';
import 'package:elektroku/controllers/product_controller.dart';
import 'package:elektroku/models/product_model.dart';
import 'package:elektroku/shared/constants/themes.dart';
import 'package:elektroku/views/cart/cart.dart';
import 'package:elektroku/views/home/widgets/banner_home.dart';
import 'package:elektroku/views/home/widgets/chip.dart';
import 'package:elektroku/views/home/widgets/hot_sales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../detail_product/detail_product.dart';

final currentIdexProvider = StateProvider<int>((ref) {
  return 0;
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productNotifierProvider);
    final currentIndex = ref.watch(currentIdexProvider);
    final itemBag = ref.watch(itemBagProvider);
    return Scaffold(
      drawer: const Drawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: secondaryColor,
            centerTitle: true,
            title: const Text(
              "Mulya Chell",
              style: ThemesFonts.Font22WhiteBold,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 15.0,
                ),
                child: Badge(
                  label: Text(itemBag.length.toString()),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.local_mall,
                      size: 24.0,
                      color: grayColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const BannerHome(),
                SizedBox(
                  height: 50.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      ChipWidget(
                        chipLabel: "All",
                      ),
                      ChipWidget(
                        chipLabel: "Computers",
                      ),
                      ChipWidget(
                        chipLabel: "Headsets",
                      ),
                      ChipWidget(
                        chipLabel: "Accessories",
                      ),
                      ChipWidget(
                        chipLabel: "Printing",
                      ),
                      ChipWidget(
                        chipLabel: "Camera",
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
                        "Hot Sales",
                        style:
                            ThemesFonts.Font14Black.copyWith(color: blackColor),
                      ),
                      Text(
                        "See All",
                        style: ThemesFonts.Font12.copyWith(color: blueColor),
                      ),
                    ],
                  ),
                ),
                HotSalesProduct(getIndex: currentIndex),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Featured Products",
                        style:
                            ThemesFonts.Font14Black.copyWith(color: blackColor),
                      ),
                      Text(
                        "See All",
                        style: ThemesFonts.Font12.copyWith(color: blueColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: .7 / .9),
                itemCount: product.length,
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
                        if (product[index].isSelected == false) {
                          ref.read(itemBagProvider.notifier).addNewItemBg(
                                ProductModel(
                                    id: product[index].id,
                                    imgUrl: product[index].imgUrl,
                                    title: product[index].title,
                                    price: product[index].price,
                                    shortDescription:
                                        product[index].shortDescription,
                                    longDescription:
                                        product[index].longDescription,
                                    review: product[index].review,
                                    rating: product[index].rating),
                              );
                        } else {
                          ref
                              .read(itemBagProvider.notifier)
                              .removeItem(product[index].id);
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) =>
            ref.read(currentIdexProvider.notifier).update((state) => value),
        selectedItemColor: blackColor,
        unselectedItemColor: darkGrayColor,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 24.0,
              ),
              activeIcon: Icon(
                Icons.home_filled,
                size: 24.0,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 24.0,
              ),
              activeIcon: Icon(
                Icons.search_outlined,
                size: 24.0,
              ),
              label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border_outlined,
                size: 24.0,
              ),
              activeIcon: Icon(
                Icons.favorite,
                size: 24.0,
              ),
              label: 'Favorite'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
                size: 24.0,
              ),
              activeIcon: Icon(
                Icons.notifications_active,
                size: 24.0,
              ),
              label: 'Notif'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 24.0,
              ),
              activeIcon: Icon(
                Icons.person,
                size: 24.0,
              ),
              label: 'Profile'),
        ],
      ),
    );
  }
}
