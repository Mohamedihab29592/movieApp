import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movie/presentation/screens/wishlist.dart';
import '../../../core/utilies/assets.dart';
import '../../../core/utilies/strings.dart';
import '../controllers/mainScreen/bloc.dart';
import '../controllers/mainScreen/bloc_events.dart';
import 'movie_search.dart';
import 'movies_screen.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final movieBloc = context.read<MovieBloc>();
      movieBloc.add(GetTrendMoviesEvent());
      movieBloc.add(GetNowPlayingMoviesEvent());



      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) {
          movieBloc.add(GetTopRatedMoviesEvent());
          movieBloc.add(GetUpComingMoviesEvent());
        }
      });

      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) {
          movieBloc.add(GetPopularMoviesEvent());
        }
      });
    });
  }

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
            icon: ImageIcon(AssetImage(Assets.homeIcon)),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(Assets.searchIcon)),
            label: AppStrings.search,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(Assets.wishListIcon)),
            label: AppStrings.wishList,
          ),
        ],
      ),
    );
  }
}

