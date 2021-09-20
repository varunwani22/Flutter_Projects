import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  late final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavroite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavroite = false,
  });

  void toggleFavroiteStatus() {
    isFavroite = !isFavroite;
    notifyListeners();
  }
}
