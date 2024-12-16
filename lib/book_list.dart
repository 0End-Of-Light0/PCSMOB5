import 'dart:io';
import 'package:flutter/material.dart';
import 'book_data.dart';
import 'book_detail.dart';
import 'book_add.dart';

class BookListPage extends StatefulWidget {
  final Map<int, bool> favoriteStatus;
  final List<Product> favoriteBooks;
  final void Function(Product) onFavoriteToggle;

  const BookListPage({
    Key? key,
    required this.favoriteStatus,
    required this.favoriteBooks,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = ProductRepository.loadProducts();
  }

  void _refreshProductList() {
    setState(() {
      _productsFuture = ProductRepository.loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('e-Book List'),
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            final products = snapshot.data ?? [];
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final isFavorite = widget.favoriteStatus[product.id] ?? false;
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                  leading: _buildProductImage(product.image),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                    onPressed: () => widget.onFavoriteToggle(product),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailPage(
                          product: product,
                          onProductDeleted: _refreshProductList,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBookPage(
                onProductAdded: _refreshProductList,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildProductImage(String imagePath) {
    final file = File(imagePath);
    if (file.existsSync()) {
      return Image.file(
        file,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        imagePath, // Укажите путь к заглушке в ассетах
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    }
  }
}
