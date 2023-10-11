import 'package:elektroku/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductNotifier extends StateNotifier<List<ProductModel>> {
  ProductNotifier() : super(productItem);
  void isSelectItem(id, index) {
    state = [
      for (final product in state)
        if (product.id == id)
          product.copyWith(isSelected: state[index].isSelected)
        else
          product
    ];
  }

  void increment(int pid) {
    state = [
      for (final product in state)
        if (product.id == pid)
          product.copyWith(qty: product.qty! + 1)
        else
          product,
    ];
  }

  void decrement(int pid) {
    state = [
      for (final product in state)
        if (product.id == pid)
          product.copyWith(qty: product.qty! - 1)
        else
          product,
    ];
  }
}

final productNotifierProvider =
    StateNotifierProvider<ProductNotifier, List<ProductModel>>((ref) {
  return ProductNotifier();
});
