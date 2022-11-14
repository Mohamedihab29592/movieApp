import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/utilies/appStrings.dart';
import 'package:movie_app/movie/presentation/controllers/mainScreen/bloc.dart';
import 'package:movie_app/movie/presentation/controllers/mainScreen/blocStates.dart';
import 'package:movie_app/movie/presentation/controllers/themeMode/theme_mode_cubit.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utilies/colors.dart';
import '../../../core/utilies/values_manger.dart';
import '../controllers/mainScreen/blocEvents.dart';
import '../widgets/movieScreen/nowPlayingWidget.dart';
import '../widgets/movieScreen/seeMoreWidget.dart';
import '../widgets/movieScreen/popularWidget.dart';
import '../widgets/movieScreen/topRelatedWidget.dart';
import '../widgets/movieScreen/upcomingWidgets.dart';
import 'movieSearch.dart';

class MoviesScreen extends StatelessWidget {
 final  BuildContext context;
  const MoviesScreen({Key? key, required this.context}) : super(key: key);



  Future _refresh() async {
  sl<MovieBloc>()..add(GetNowPlayingMoviesEvent())..add(GetPopularMoviesEvent())..add(GetUpComingMoviesEvent());
   return Future.delayed(const Duration(seconds: 2), () {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MoviesScreen(context: context,)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh:_refresh,
      child: Scaffold(
        body: CustomScrollView(

            slivers: [
          SliverAppBar(


            actions: [
              IconButton(
                  onPressed: () {
                    ThemeModeCubit.get(context).changeAppMode();
                  },
                  icon: const Icon(Icons.brightness_4) ,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const MovieSearch()));
                  },
                  icon:  const Icon(Icons.search))
            ],
            pinned: true,
            expandedHeight: 575,
            flexibleSpace: FlexibleSpaceBar(
              background: FadeIn(
                duration: Duration(milliseconds: AppSize.s500.toInt()),
                child: const NowPlayingWidget(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSize.s10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.popular,
                        style: GoogleFonts.poppins(
                          fontSize: AppSize.s20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: AppSize.s0_5,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                       BlocBuilder<MovieBloc,MovieState>(builder: (context,state)=> SeeMoreWidget(title: AppStrings.popularMovies, widgetState: state.popularState, listLength: state.popularMovies.length, movieList: state.popularMovies, movieMessage: state.popularMessage,))
                              )
                          );
                        },
                        child: Row(
                          children: const [
                            Text(AppStrings.seeMore,style: TextStyle(color: AppColors.teal),),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: AppSize.s16,
                                color: AppColors.teal
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const PopularWidget(),
                Padding(
                  padding: const EdgeInsets.all(AppSize.s10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.topRated,
                        style: GoogleFonts.poppins(
                          fontSize: AppSize.s20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: AppSize.s0_5,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                              BlocBuilder<MovieBloc,MovieState>(builder: (context,state)=> SeeMoreWidget(title: AppStrings.topRatedMovies, widgetState: state.topRatedState, listLength: state.topRatedMovies.length, movieList: state.topRatedMovies, movieMessage: state.topRatedMessage,))
                              ));
                        },
                        child: Row(
                          children: const [
                            Text(
                              AppStrings.seeMore,style: TextStyle(color: AppColors.teal),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: AppSize.s16,
                                color: AppColors.teal
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const TopRelatedWidget(),
                Padding(
                  padding: const EdgeInsets.all(AppSize.s10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.upComing,
                        style: GoogleFonts.poppins(
                          fontSize: AppSize.s20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: AppSize.s0_5,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                              BlocBuilder<MovieBloc,MovieState>(builder: (context,state)=> SeeMoreWidget(title: AppStrings.upComingMovies, widgetState: state.upComingState, listLength: state.upComingMovies.length, movieList: state.upComingMovies, movieMessage: state.upComingMessage,))));
                                  },
                        child: Padding(
                          padding: const EdgeInsets.all(AppSize.s8),
                          child: Row(
                            children: const [
                              Text(
                                AppStrings.seeMore,style: TextStyle(color: AppColors.teal),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: AppSize.s16,
                                  color: AppColors.teal

                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const UpComingWidget(),
                const SizedBox(height: AppSize.s50),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}




