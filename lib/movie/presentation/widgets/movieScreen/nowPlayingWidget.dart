import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utilies/values_manger.dart';
import 'package:movie_app/movie/presentation/controllers/mainScreen/bloc.dart';
import 'package:movie_app/movie/presentation/widgets/movieScreen/seeMoreWidget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utilies/appStrings.dart';
import '../../../../core/utilies/colors.dart';
import '../../../../core/utilies/constants.dart';
import '../../controllers/mainScreen/blocStates.dart';
import '../../screens/movie_detail_screen.dart';

class NowPlayingWidget extends StatelessWidget {
  const NowPlayingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
        buildWhen: (previous, current) =>previous.nowPlayingState!=current.nowPlayingState,

        builder: (context, state) {
          return  FadeIn(
            duration: const Duration(milliseconds: 500),

            child: Column(
              children: [
                Expanded(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 900,
                      autoPlay: true,
                      viewportFraction: AppSize.s1,

                    ),
                    items: state.nowPlayingMovies.map(
                          (item) {
                        return GestureDetector(
                          onTap: () {
                            print(item.id);

                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetailScreen(id: item.id,)));
                          },

                          child: ShaderMask(
                            shaderCallback: (rect) {
                              return const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  // fromLTRB
                                  Colors.transparent,
                                  Colors.black,
                                  Colors.black,
                                  Colors.transparent,
                                ],
                                stops: [0, 0.3, 0.5, 1],
                              ).createShader(
                                Rect.fromLTRB(0, 0, rect.width, rect.height),
                              );
                            },
                            blendMode: BlendMode.dstIn,
                            child: CachedNetworkImage(
                              width: double.infinity,
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
                              imageUrl: AppConstants.imageUrl(item.posterPath!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
                const SizedBox(height: AppSize.s10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:    [
                    const Icon(
                      Icons.circle,
                      color: Colors.redAccent,
                      size: AppSize.s16,
                    ),
                    const SizedBox(width: AppSize.s4),
                   TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> SeeMoreWidget(title: AppStrings.nowPlaying, widgetState: state.nowPlayingState, listLength: state.nowPlayingMovies.length, movieList:state.nowPlayingMovies, movieMessage: state.nowPlayingMessage,)));}, child:const Text(
                     AppStrings.nowPlaying,
                     style: TextStyle(
                         fontSize: AppSize.s16,
                         color: AppColors.red
                     ),
                   ),)
                  ],
                ),
              ],
            ),
          );

      }
    );
  }
}
