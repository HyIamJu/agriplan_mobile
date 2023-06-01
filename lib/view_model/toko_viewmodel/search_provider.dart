import 'package:mobile_flutter/models/toko_model.dart';
import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  late List<BaseModel> filteredProducts;
  late List<BaseModel> allProducts;

  SearchProvider({required List<BaseModel> products}) {
    allProducts = List.from(products);
    filteredProducts = List.from(products);
  }

  void onSearch(String search) {
    filteredProducts = filteredProducts
        .where((product) =>
            product.name.toLowerCase().contains(search.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void resetFilter() {
    filteredProducts = List.from(allProducts);
    notifyListeners();
  }

  void filterProducts(String keyword) {
    allProducts = allProducts
        .where((product) =>
            product.name.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void resetall() {
    allProducts = List.from(allProducts);
    notifyListeners();
  }
}
