import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/utilies/strings.dart';
import 'package:movie_app/core/utilies/colors.dart';
import 'package:movie_app/movie/presentation/controllers/mainScreen/bloc.dart';
import 'package:movie_app/movie/presentation/controllers/themeMode/theme_mode_cubit.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utilies/values_manger.dart';
import '../controllers/mainScreen/bloc_events.dart';
import '../widgets/movieScreen/now_playing_widget.dart';
import '../widgets/movieScreen/popular_widget.dart';
import '../widgets/movieSearch/search_body.dart';
import '../widgets/movieScreen/top_related_widget.dart';
import '../widgets/movieScreen/trend_widget.dart';
import '../widgets/movieScreen/upcoming_widgets.dart';
import 'Layout.dart';



class MoviesScreen extends StatelessWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  Future<void> _refresh(BuildContext context) async {
    final bloc = MovieBloc(sl(), sl(), sl(), sl(), sl(),);
    bloc.add(GetTrendMoviesEvent());
    bloc.add(GetNowPlayingMoviesEvent());
    bloc.add(GetPopularMoviesEvent());
    bloc.add(GetUpComingMoviesEvent());
    await Future.delayed(const Duration(seconds: 2));
    if(context.mounted) {
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Layout()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return RefreshIndicator(
      onRefresh: () => _refresh(context),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text(
            AppStrings.appName,
            style: GoogleFonts.poppins(
              fontSize: AppSize.s20,
              fontWeight: FontWeight.bold,
              letterSpacing: AppSize.s0_5,
            ),
          ),
          actions: [
            IconButton(
            onPressed: () {
              ThemeModeCubit.get(context).changeAppMode();
            },
            icon: const Icon(Icons.brightness_4),
          ),],
          ),
          body: Padding(
            padding: const EdgeInsets.all(AppSize.s20),
            child: Form(
              key: formKey,
              child: const SingleChildScrollView(
                physics:  BouncingScrollPhysics(),
                child: Column(
                  spacing: 20,
                  children: [
                    SearchBody(isMain: false,),
                    TrendWidget(),
                    _MovieTabsView(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MovieTabsView extends StatefulWidget {
  const _MovieTabsView({Key? key}) : super(key: key);

  @override
  State<_MovieTabsView> createState() => _MovieTabsViewState();
}

class _MovieTabsViewState extends State<_MovieTabsView> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  final List<String> tabs = [
    AppStrings.nowPlaying,
    AppStrings.upComing,
    AppStrings.topRated,
    AppStrings.popular,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(tabs.length, (index) {
              final isSelected = _selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() => _selectedIndex = index);
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      tabs[index],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight:
                      FontWeight.bold ,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 2,
                      width: 80,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.softGrey : Colors.transparent,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),

        const SizedBox(height: 16),

        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _selectedIndex = index);
            },
            children: const [
              NowPlayingWidget(),
              UpComingWidget(),
              TopRatedWidget(),
              PopularWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
