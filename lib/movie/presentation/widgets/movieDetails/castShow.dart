import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utilies/constants.dart';
import 'package:shimmer/shimmer.dart';

import '../../controllers/cast/cast_bloc.dart';

class ShowCast extends StatelessWidget {
  final int id;

  const ShowCast({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastBloc, CastState>(
      builder: (context, state) {
        if (state.cast!= null) {
          return SizedBox(
            height: MediaQuery.of(context).size.height *.20,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 10,),
              itemCount: state.cast!.length,
              itemBuilder: (context, index) {
                {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        placeholder: (context, url) =>
                            Shimmer.fromColors(
                              baseColor: Colors.grey[850]!,
                              highlightColor: Colors.grey[800]!,
                              child: Container(
                                height: 75,
                                width: 75,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                            ),
                        errorWidget: (context, url, error) =>
                            Shimmer.fromColors(
                              baseColor: Colors.grey[850]!,
                              highlightColor: Colors.grey[800]!,
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: const Icon(Icons.image, size: 70,),
                              ),
                            ),
                        imageBuilder: (context, imageProvider) =>
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: imageProvider
                                  )
                              ),
                            ),
                        imageUrl:
                        AppConstants.imageUrl(state.cast![index].image!),
                      ),
                      const SizedBox(height: 5,),
                      ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 80,
                          ),
                          child: Text(state.cast![index].name, style: const TextStyle(
                              color: Colors.white70,
                              overflow: TextOverflow.ellipsis
                          ), maxLines: 2,)),

                    ],
                  );
                }

              }

        ),
          );
        }
        else
          {
            return const Text("nocast");
          }
      },
    );
  }
}
