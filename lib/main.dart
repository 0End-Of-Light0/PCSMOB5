import 'package:flutter/material.dart';
import 'book_detail.dart';
import 'book_list.dart';
import 'favorites_page.dart';
import 'profile_page.dart';
import 'book_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'e-Book App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Product> _favoriteBooks = [];
  final Map<int, bool> _favoriteStatus = {};

  void _toggleFavorite(Product product) {
    setState(() {
      final isFavorite = _favoriteStatus[product.id] ?? false;
      _favoriteStatus[product.id] = !isFavorite;

      if (!isFavorite) {
        _favoriteBooks.add(product);
      } else {
        _favoriteBooks.removeWhere((item) => item.id == product.id);
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      BookListPage(
        favoriteStatus: _favoriteStatus,
        onFavoriteToggle: _toggleFavorite,
        favoriteBooks: _favoriteBooks,
      ),
      FavoritesPage(
        favoriteBooks: _favoriteBooks,
        onFavoriteTapped: (product) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailPage(
                product: product,
                onProductDeleted: () {}, // Если нужно, обновите тут логику удаления
              ),
            ),
          );
        },
      ),
      ProfilePage(),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
