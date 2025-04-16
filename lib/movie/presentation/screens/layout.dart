import 'package:flutter/material.dart';
import 'package:movie_app/movie/presentation/screens/wishlist.dart';

import 'movieSearch.dart';
import 'movies_screen.dart';

class Layout extends StatefulWidget {

  const Layout({super.key, });

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MoviesScreen(),
    const MovieSearch(),
    const WishList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(


        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.panorama_wide_angle_sharp),
            label: 'Wish list',
          ),
        ],
      ),
    );
  }
}
