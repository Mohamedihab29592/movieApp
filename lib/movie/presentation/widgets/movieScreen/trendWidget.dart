import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/utilies/colors.dart';
import '../../../../core/utilies/constants.dart';
import '../../../../core/utilies/values_manger.dart';
import '../../controllers/mainScreen/bloc.dart';
import '../../controllers/mainScreen/blocStates.dart';

class TrendWidget extends StatelessWidget {
  const TrendWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      buildWhen: (previous, current) => previous.trendState != current.trendState,
      builder: (context, state) {
        return FadeIn(
          duration: Duration(milliseconds: AppSize.s500.toInt()),
          child: SizedBox(
            height: 300,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
              itemCount: state.trendMovies.length,
              itemBuilder: (context, index) {
                final movie = state.trendMovies[index];
                return Container(

                  padding: const EdgeInsets.only(right: AppSize.s40),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
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

                      Positioned(
                        bottom: 50,
                        left: -7,
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