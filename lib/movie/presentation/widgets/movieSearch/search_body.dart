import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utilies/strings.dart';
import '../../../../core/utilies/toast.dart';
import '../../../../core/utilies/values_manger.dart';
import '../../controllers/search/search_bloc.dart';
import '../search_textform.dart';
import '../text_widget.dart';
import 'movie_search_widget.dart';

class SearchBody extends StatelessWidget {
  final bool isMain;

  const SearchBody({Key? key, required this.isMain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context,state){
        if(state is SearchError) {
          showToast(text: state.message, state: ToastStates.error);
        }
      },
      builder: (context, state) {
        final controller = SearchBloc.get(context).searchController;
        final formKey = GlobalKey<FormState>();

        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              spacing: AppSize.s20,
              children: [
                MyFormField(
                  controller: controller,
                  onClear: () {
                    controller.clear();
                    context.read<SearchBloc>().add(ClearSearchEvent());
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onSearch: () {
                    if (formKey.currentState!.validate()) {
                      context
                          .read<SearchBloc>()
                          .add(GetSearchMovieEvent(controller.text));
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  },
                ),
                if (state is SearchLoading)
                  const SizedBox(
                    height: AppSize.s400,
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                if (controller.text.isEmpty && state is! SearchLoaded && isMain)
                  const SizedBox(
                    height: AppSize.s500,
                    child: Center(
                      child: Text(
                        AppStrings.searchMovies,
                        style: TextStyle(fontSize: AppSize.s20),
                      ),
                    ),
                  ),
                if (state is SearchLoaded)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextWidget(
                        text: AppStrings.searchResult,
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: state.movie.length,
                        itemBuilder: (context, index) {
                          final movie = state.movie[index];
                          return MovieSearchWidget(movieSearch: movie);
                        },
                      ),
                    ],
                  ),


        ],
            ),
          ),
        );
      },
    );
  }
}
