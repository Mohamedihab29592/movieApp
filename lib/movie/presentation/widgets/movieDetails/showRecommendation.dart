import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utilies/constants.dart';
import '../../../../core/utilies/values_manger.dart';
import '../../controllers/movieDetails/movie_details_bloc.dart';
import '../../controllers/movieDetails/movie_details_state.dart';
import '../../screens/movie_detail_screen.dart';

class ShowRecommendation extends StatelessWidget {
  const ShowRecommendation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) => SliverGrid(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final recommendation = state.movieRecommendation[index];
            if (recommendation.posterPath != null) {
              return FadeInUp(
                from: 20,
                duration: Duration(milliseconds: AppSize.s500.toInt()),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MovieDetailScreen(
                              id: recommendation.id,
                            )));
                  },
                  child: ClipRRect(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(AppSize.s4)),
                    child: CachedNetworkImage(
                      imageUrl:
                      AppConstants.imageUrl(recommendation.posterPath!),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[850]!,
                        highlightColor: Colors.grey[800]!,
                        child: Container(
                          height: AppSize.s170,
                          width: AppSize.s120,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(AppSize.s8),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                      height: 180.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }
            else {
              return Shimmer.fromColors(
                baseColor: Colors.grey[850]!,
                highlightColor: Colors.grey[800]!,
                child: Container(
                  height: AppSize.s170,
                  width: AppSize.s120,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(AppSize.s8),
                  ),
                ),
              );
            }
          },
          childCount: state.movieRecommendation.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: AppSize.s8,
          crossAxisSpacing: AppSize.s8,
          childAspectRatio: AppSize.s0_5,
          crossAxisCount: AppSize.s3.toInt(),
        ),
      ),
    );
  }
}
