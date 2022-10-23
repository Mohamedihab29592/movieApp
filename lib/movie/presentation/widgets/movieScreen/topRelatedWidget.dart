import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movie/presentation/controllers/mainScreen/bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utilies/constants.dart';
import '../../../../core/utilies/values_manger.dart';
import '../../controllers/mainScreen/blocStates.dart';
import '../../screens/movie_detail_screen.dart';

class TopRelatedWidget extends StatelessWidget {
  const TopRelatedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<MovieBloc,MovieState>(
      buildWhen: (previous, current) => previous.topRatedState != current.topRatedState ,

        builder: (context,state){
          return  FadeIn(
            duration:  Duration(milliseconds: AppSize.s500.toInt()),
            child: SizedBox(
              height: AppSize.s170,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
                itemCount: state.topRatedMovies.length,
                itemBuilder: (context, index) {
                  final movie = state.topRatedMovies[index];
                  return Container(
                    padding: const EdgeInsets.only(right: AppSize.s8),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetailScreen(id: movie.id,)));
                      },
                      child: ClipRRect(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(AppSize.s8)),
                        child: CachedNetworkImage(
                          width: AppSize.s120,
                          fit: BoxFit.cover,
                          imageUrl: AppConstants.imageUrl(movie.posterPath!),
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
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );

    });
  }
}
