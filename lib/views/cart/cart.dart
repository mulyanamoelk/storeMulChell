import 'package:elektroku/controllers/item_bag_controller.dart';
import 'package:elektroku/shared/constants/themes.dart';
import 'package:elektroku/shared/extentions/money.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemBag = ref.watch(itemBagProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: grayColor,
            size: 24.0,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Keranjangku",
          style: ThemesFonts.Font22WhiteBold,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 15.0,
            ),
            child: Badge(
              label: Text(itemBag.length.toString()),
              child: const Icon(
                Icons.local_mall,
                color: grayColor,
                size: 24.0,
              ),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                color: whiteColor,
              ),
              child: ListView.builder(
                itemCount: itemBag.length,
                itemBuilder: (context, index) {
                  final cart = itemBag[index];
                  final totalPrice = cart.price * cart.qty!;
                  final productLength = itemBag.length;
                  final getTotal = totalPrice * productLength;

                  print(getTotal);
                  return Slidable(
                    startActionPane:
                        ActionPane(motion: const ScrollMotion(), children: [
                      SlidableAction(
                        label: 'Edit',
                        icon: Icons.update,
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        onPressed: (context) {},
                      ),
                    ]),
                    endActionPane:
                        ActionPane(motion: const ScrollMotion(), children: [
                      SlidableAction(
                        label: 'Hapus',
                        icon: Icons.delete,
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        onPressed: (context) {
                          ref
                              .watch(itemBagProvider.notifier)
                              .removeItem(itemBag[index].id);
                        },
                      )
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Card(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.asset(cart.imgUrl),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cart.title,
                                      style: ThemesFonts.Font14Black,
                                    ),
                                    Text(
                                      cart.shortDescription,
                                      style: ThemesFonts.Font12.copyWith(
                                        color: blackColor.withOpacity(.2),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          totalPrice.formatRupiah(),
                                          style: ThemesFonts.Font14Black,
                                        ),
                                        Text("${cart.qty} X"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Have a coupon code? enter here'),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 1,
                          color: secondaryColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'FDS2023',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            child: const Row(
                              children: [
                                Text(
                                  'Available',
                                  style: TextStyle(
                                      color: secondaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(Icons.check_circle)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery Fee:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Free',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Discount:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'No discount',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: secondaryColor),
                        ),
                        Text(
                          "Rp. ${ref.watch(pricecalTotal)}",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomSheet: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50.0,
        child: ElevatedButton(
          style: const ButtonStyle(),
          onPressed: () {},
          child: const Text("Checkout"),
        ),
      ),
    );
  }
}
