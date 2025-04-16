import 'package:flutter/material.dart';
import 'package:movie_app/movie/presentation/widgets/movieScreen/popularWidget.dart';
import 'package:movie_app/movie/presentation/widgets/movieScreen/topRelatedWidget.dart';
import 'package:movie_app/movie/presentation/widgets/movieScreen/upcomingWidgets.dart';

import 'nowPlayingWidget.dart';

class MovieCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Movies'),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Now playing'),
              Tab(text: 'Upcoming'),
              Tab(text: 'Top rated'),
              Tab(text: 'Popular'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            NowPlayingWidget(),
            UpComingWidget(),
            TopRatedWidget(),
            PopularWidget(),
          ],
        ),
      ),
    );
  }
}
