import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utilies/values_manger.dart';
import 'package:movie_app/movie/presentation/controllers/mainScreen/bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/utilies/constants.dart';
import '../../controllers/mainScreen/blocStates.dart';
import '../../screens/movie_detail_screen.dart';

class NowPlayingWidget extends StatelessWidget {
  const NowPlayingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      buildWhen: (previous, current) =>
      previous.nowPlayingState != current.nowPlayingState,
      builder: (context, state) {
        return FadeIn(
          duration: Duration(milliseconds: AppSize.s500.toInt()),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: state.nowPlayingMovies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Two items per row
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2 / 3, // Aspect ratio for poster-like shape
              ),
              itemBuilder: (context, index) {
                final movie = state.nowPlayingMovies[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(id: movie.id),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(AppSize.s8)),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: AppConstants.imageUrl(movie.posterPath!),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[850]!,
                        highlightColor: Colors.grey[800]!,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(AppSize.s8),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
