import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/utilies/appStrings.dart';
import 'package:movie_app/movie/presentation/controllers/mainScreen/bloc.dart';
import 'package:movie_app/movie/presentation/controllers/themeMode/theme_mode_cubit.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utilies/values_manger.dart';
import '../controllers/mainScreen/blocEvents.dart';
import '../controllers/search/search_bloc.dart';
import '../widgets/movieScreen/nowPlayingWidget.dart';
import '../widgets/movieScreen/popularWidget.dart';
import '../widgets/search_textForm.dart';
import '../widgets/movieScreen/topRelatedWidget.dart';
import '../widgets/movieScreen/trendWidget.dart';
import '../widgets/movieScreen/upcomingWidgets.dart';
import 'Layout.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({Key? key, }) : super(key: key);

  Future<void> _refresh(BuildContext context) async {
    final bloc = MovieBloc(sl(),sl(),sl(),sl(),sl());
    bloc.add(GetTrendMoviesEvent());
    bloc.add(GetNowPlayingMoviesEvent());
    bloc.add(GetPopularMoviesEvent());
    bloc.add(GetUpComingMoviesEvent());
     await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Layout()));  }




  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final formKey = GlobalKey<FormState>();


    return RefreshIndicator(
      onRefresh: () => _refresh(context),
      child: Scaffold(
        body: CustomScrollView(

            slivers: [
          SliverAppBar(



            actions: [
               Padding(
                 padding: const EdgeInsets.only(left: AppSize.s20),
                 child: Text('What do you want to watch?',style: GoogleFonts.poppins(
                             fontSize: AppSize.s20,
                             fontWeight: FontWeight.bold,
                             letterSpacing: AppSize.s0_5,)),
               ),
              const Spacer(),

              IconButton(
                  onPressed: () {
                    ThemeModeCubit.get(context).changeAppMode();
                  },
                  icon: const Icon(Icons.brightness_4) ,
              ),

            ],

          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSize.s20),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: AppSize.s20,

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyFormField(controller: controller,
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context
                                .read<SearchBloc>()
                                .add(GetSearchMovieEvent(controller.text));

                            FocusManager.instance.primaryFocus!.unfocus();
                          }
                        },
                        icon: const Icon(
                          Icons.search,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.trend,
                          style: GoogleFonts.poppins(
                            fontSize: AppSize.s20,
                            fontWeight: FontWeight.w500,
                            letterSpacing: AppSize.s0_5,
                          ),
                        ),

                      ],
                    ),
                    const TrendWidget(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.nowPlaying,
                          style: GoogleFonts.poppins(
                            fontSize: AppSize.s20,
                            fontWeight: FontWeight.w500,
                            letterSpacing: AppSize.s0_5,
                          ),
                        ),

                      ],
                    ),
                    const NowPlayingWidget(),
                    Row(
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

                      ],
                    ),
                    const PopularWidget(),
                    Row(
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

                      ],
                    ),
                    const TopRelatedWidget(),
                    Row(
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

                      ],
                    ),
                    const UpComingWidget(),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}




