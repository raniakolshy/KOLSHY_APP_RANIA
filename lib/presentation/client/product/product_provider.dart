// Fichier : lib/providers/product_provider.dart

import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  Map<String, dynamic>? _selectedProduct;

  Map<String, dynamic>? get selectedProduct => _selectedProduct;

  void setSelectedProduct(Map<String, dynamic> product) {
    _selectedProduct = product;
    notifyListeners();
  }

  void clearSelectedProduct() {
    _selectedProduct = null;
    notifyListeners();
  }
}