import 'dart:io';
import 'package:flutter/material.dart';
import 'book_data.dart';

class FavoritesPage extends StatelessWidget {
  final List<Product> favoriteBooks;
  final void Function(Product) onFavoriteTapped;

  const FavoritesPage({
    Key? key,
    required this.favoriteBooks,
    required this.onFavoriteTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.blue,
      ),
      body: favoriteBooks.isEmpty
          ? const Center(
              child: Text(
                'Your favorite books will appear here.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: favoriteBooks.length,
              itemBuilder: (context, index) {
                final product = favoriteBooks[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                  leading: _buildProductImage(product.image),
                  onTap: () => onFavoriteTapped(product),
                );
              },
            ),
    );
  }

  Widget _buildProductImage(String imagePath) {
    final file = File(imagePath);
    if (file.existsSync()) {
      // Если файл существует в локальном хранилище, используем его.
      return Image.file(
        file,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    } else {
      // Если файл не найден, используем изображение из ассетов.
      return Image.asset(
        imagePath,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    }
  }
}
