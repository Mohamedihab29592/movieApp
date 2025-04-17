import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/error/internet_check.dart';
import '../../../../core/utilies/colors.dart';
import '../../../../core/utilies/constants.dart';
import '../../../../core/utilies/enum.dart';
import '../../../../core/utilies/toast.dart';
import '../../../../core/utilies/values_manger.dart';
import '../../controllers/mainScreen/bloc.dart';
import '../../controllers/mainScreen/bloc_states.dart';
import '../../screens/movie_detail_screen.dart';

class TrendWidget extends StatelessWidget {
  const TrendWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieBloc, MovieState>(
      listener: (context,state) async {
        await NetworkInfoImpl().checkInternet();

        if(state.trendState == RequestState.error) {
          showToast(text: state.trendMessage, state: ToastStates.error);
        }
      },
      buildWhen: (previous, current) => previous.trendState != current.trendState,
      builder: (context, state) {
        final isLoading = state.trendState == RequestState.loading;
        final movies = state.trendMovies;
        final showShimmer = isLoading || movies.isEmpty;

        return FadeIn(
          duration: Duration(milliseconds: AppSize.s500.toInt()),
          child: SizedBox(
            height: AppSize.s250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
              itemCount: showShimmer ? 5 : movies.length,
              itemBuilder: (context, index) {
                if (showShimmer) {
                  return Container(
                    width: AppSize.s190,
                    padding: const EdgeInsets.only(right: AppSize.s40),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[850]!,
                      highlightColor: Colors.grey[800]!,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  );
                }

                final movie = movies[index];
                return Container(
                  padding: const EdgeInsets.only(right: AppSize.s40),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailScreen(id: movie.id),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            imageUrl: AppConstants.imageUrl(movie.posterPath!),
                            fit: BoxFit.fill,
                            width: 144.6,
                            height: 210,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[850]!,
                              highlightColor: Colors.grey[800]!,
                              child: Container(
                                width: 144.6,
                                height: 210,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        left: -10,
                        child: Stack(
                          children: [
                            Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                fontSize: 98,
                                height: 1.0,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 2
                                  ..color = Colors.blue.shade800,
                              ),
                            ),
                            Text(
                              '${index + 1}',
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                fontSize: 96,
                                height: 1.0,
                                color: AppColors.defaultColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
