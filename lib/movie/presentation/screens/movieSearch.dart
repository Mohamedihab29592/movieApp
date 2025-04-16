import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utilies/appStrings.dart';
import '../../../core/utilies/values_manger.dart';
import '../controllers/search/search_bloc.dart';
import '../widgets/search_textForm.dart';
import '../widgets/movieSearch/movieSearchWidget.dart';

class MovieSearch extends StatelessWidget {
  const MovieSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(sl()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.search),
          centerTitle: true,
        ),
        body:const SearchBody(),
      ),
    );
  }
}

class SearchBody extends StatelessWidget {
  const SearchBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final TextEditingController controller = TextEditingController();
        final formKey = GlobalKey<FormState>();
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(AppSize.s20),
              child: Column(
                spacing: 20,
                children: [
                  MyFormField(
                    controller: controller,
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
                  if (state is SearchLoading)
                    const SizedBox(
                      height: AppSize.s400,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),

                  if (state is SearchLoaded)
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: state.movie.length,
                      itemBuilder: (context, index) {
                        final movie = state.movie[index];
                        return MovieSearchWidget(movieSearch: movie,);
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

