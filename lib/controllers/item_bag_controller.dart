import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';

List<ProductModel> itemBag = [];

class ItemBagNotifier extends StateNotifier<List<ProductModel>> {
  ItemBagNotifier() : super(itemBag);
  //menambahkan item baru
  void addNewItemBg(ProductModel productModel) {
    state = [...state, productModel];
  }

  //menghapus itemProduct
  void removeItem(id) {
    state = [
      for (final product in state)
        if (product.id != id) product
    ];
  }
}

final itemBagProvider =
    StateNotifierProvider<ItemBagNotifier, List<ProductModel>>((ref) {
  return ItemBagNotifier();
});

final pricecalTotal = StateProvider<double>((ref) {
  final itemBag = ref.watch(itemBagProvider);
  double sum = 0;
  for (var element in itemBag) {
    sum += element.price;
  }
  return sum;
});

