import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/utilies/appStrings.dart';
import 'package:movie_app/core/utilies/constants.dart';
import 'package:movie_app/movie/presentation/controllers/cast/cast_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utilies/colors.dart';
import '../../../core/utilies/enum.dart';
import '../../../core/utilies/values_manger.dart';
import '../../domain/entities/genres.dart';
import '../controllers/movieDetails/movie_details_bloc.dart';
import '../controllers/movieDetails/movie_details_event.dart';
import '../controllers/movieDetails/movie_details_state.dart';
import '../widgets/movieDetails/castShow.dart';
import '../widgets/movieDetails/showRecommendation.dart';

class MovieDetailScreen extends StatelessWidget {
  final int id;

  const MovieDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<MovieDetailsBloc>()
            ..add(GetMovieDetailsEvent(id))
            ..add(
              GetMovieRecommendationEvent(id),
            ),

        ),
        BlocProvider(create: (context)=>sl<CastBloc>()..add(GetCastEvent(id)))
      ],
      child:  Scaffold(
        body: MovieDetailContent(id:id),
      ),
    );
  }
}

class MovieDetailContent extends StatelessWidget {
  final int id;
  const MovieDetailContent({
    Key? key,required this.id
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
      switch (state.movieDetailsState) {
        case RequestState.loading:
          return const SizedBox(
            height: AppSize.s400,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );

        case RequestState.loaded:
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios)),

                pinned: true,
                expandedHeight: AppSize.s250,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: CachedNetworkImage(
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[850]!,
                      highlightColor: Colors.grey[800]!,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(AppSize.s8),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    imageUrl:
                        AppConstants.imageUrl(state.movieDetails!.backdropPath),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppSize.s16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(state.movieDetails!.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: AppSize.s1_2,
                                )),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSize.s2,
                              horizontal: AppSize.s8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.red,
                              borderRadius: BorderRadius.circular(AppSize.s4),
                            ),
                            child: Text(
                              state.movieDetails!.status,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: AppSize.s16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.s8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppSize.s2,
                                  horizontal: AppSize.s8,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.softGrey,
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s4),
                                ),
                                child: Text(
                                  state.movieDetails!.releaseDate
                                      .split('-')[AppSize.s0.toInt()],
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontSize: AppSize.s16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: AppSize.s20,
                              ),
                              Text(
                                " ${state.movieDetails!.voteAverage.toInt()}/10",
                                style: const TextStyle(
                                  fontSize: AppSize.s16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: AppSize.s1_2,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${state.movieDetails!.voteCount} Votes",
                            style: const TextStyle(
                              fontSize: AppSize.s16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: AppSize.s1_2,
                            ),
                          ),
                          Text(
                            _showDuration(state.movieDetails!.runtime),
                            style: const TextStyle(
                              fontSize: AppSize.s16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: AppSize.s1_2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (state.movieDetails!.budget == 0)
                            const Text(
                              AppStrings.noBudget,
                              style: TextStyle(
                                fontSize: AppSize.s16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: AppSize.s1_2,
                              ),
                            ),
                          if (state.movieDetails!.budget > 0)
                            Text(
                              "${AppStrings.budget}${state.movieDetails!.budget} \$",
                              style: const TextStyle(
                                fontSize: AppSize.s16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: AppSize.s1_2,
                              ),
                            ),
                          if (state.movieDetails!.adult == true)
                            const Text(
                              AppStrings.eighteen,
                              style: TextStyle(
                                color: AppColors.red,
                                fontSize: AppSize.s16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: AppSize.s1_2,
                              ),
                            ),
                          if (state.movieDetails!.adult == false)
                            const Text(
                              AppStrings.twelve,
                              style: TextStyle(
                                fontSize: AppSize.s16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: AppSize.s1_2,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: AppSize.s10),
                      if (state.movieDetails!.budget == 0)

                        const Text(
                        "${AppStrings.revenue}${AppStrings.noRevenue}",
                        style: TextStyle(
                          fontSize: AppSize.s16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: AppSize.s1_2,
                        ),
                      ),
                      if (state.movieDetails!.budget > 0)
                        Text(
                          "${AppStrings.revenue}${state.movieDetails!.revenue}\$",
                          style: const TextStyle(
                            fontSize: AppSize.s16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: AppSize.s1_2,
                          ),
                        ),
                      const SizedBox(height: AppSize.s10),
                      if(state.movieDetails!.company.isNotEmpty)
                        Text(
                        "${AppStrings.country}${state.movieDetails!.company[0].originCountry}",
                        style: const TextStyle(
                          fontSize: AppSize.s16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: AppSize.s1_2,
                        ),
                      ),
                      const SizedBox(height: AppSize.s10),
                      Text(
                        state.movieDetails!.overView,
                        style: const TextStyle(
                          fontSize: AppSize.s18,
                          fontWeight: FontWeight.w400,
                          letterSpacing: AppSize.s1_2,
                        ),
                      ),
                      const SizedBox(height: AppSize.s8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSize.s2,
                          horizontal: AppSize.s8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.softGrey,
                          borderRadius: BorderRadius.circular(AppSize.s4),
                        ),
                        child: Text(
                          _showGenres(state.movieDetails!.genres),
                          style: const TextStyle(
                            fontSize: AppSize.s20,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: AppSize.s1_2,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSize.s20),
                      if(state.movieDetails!.company.isNotEmpty)
                      Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(color: AppColors.grey, width: 2),),
                            child: const Text(
                              AppStrings.production,
                              style: TextStyle(
                                fontSize: AppSize.s18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: AppSize.s1_2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(AppSize.s8),
                            child: ListView.separated(
                              shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context,index)=>const SizedBox(height: AppSize.s3,),
                                  padding: EdgeInsets.zero,
                              itemBuilder: (context, index) => Text(
                                state.movieDetails!.company[index].name,
                                style: const TextStyle(
                                  fontSize: AppSize.s16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: AppSize.s1_2,
                                ),
                              ),
                              itemCount: state.movieDetails!.company.length,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.s8),
                      ShowCast(id:id),
                    ],
                  ),
                ),
              ),
              if(state.movieRecommendation.isNotEmpty)

                SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                    AppSize.s16, AppSize.s16, AppSize.s16, AppSize.s24),
                sliver: SliverToBoxAdapter(
                  child: FadeInUp(
                    from: 20,
                    duration: Duration(milliseconds: AppSize.s500.toInt()),
                    child: const Text(
                      AppStrings.moreLikeThis,
                      style: TextStyle(
                        fontSize: AppSize.s16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: AppSize.s1_2,
                      ),
                    ),
                  ),
                ),
              ),
              if(state.movieRecommendation.isNotEmpty)

                const SliverPadding(
                padding: EdgeInsets.fromLTRB(
                    AppSize.s16, AppSize.s0, AppSize.s16, AppSize.s24),
                sliver: ShowRecommendation(),
              ),
            ],
          );
        case RequestState.error:
          return SizedBox(
            height: AppSize.s400,
            child: Center(
              child: Text(state.movieDetailsMessage),
            ),
          );
      }
    });
  }

  String _showGenres(List<Genres> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - AppSize.s2.toInt());
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ AppSize.s60;
    final int minutes = runtime % AppSize.s60.toInt();

    if (hours > AppSize.s0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }



}

