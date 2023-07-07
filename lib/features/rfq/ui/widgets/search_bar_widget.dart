import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/search_controller/search_bloc.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key, required this.searchController});
  final SearchController searchController;

  @override
  Widget build(BuildContext context) {
    final SearchBloc searchBloc = context.read<SearchBloc>();
    return SizedBox(
      height: 40,
      child: SearchAnchor.bar(
          barElevation: const MaterialStatePropertyAll(0),
          suggestionsBuilder: (context, controller) {
            if (searchController.text.isEmpty) {
              if (searchBloc.searchHistory.isEmpty) {
                return [const Center(child: Text("No History found"))];
              }
              return searchBloc.searchHistory.map((e) => ListTile(
                    leading: const Icon(Icons.history),
                    title: Text(e),
                    trailing: IconButton(
                      icon: const Icon(Icons.call_missed),
                      onPressed: () {
                        controller.text = e;
                        controller.selection = TextSelection.collapsed(
                            offset: controller.text.length);
                      },
                    ),
                  ));
            }
            return getSuggestion(searchController);
          }),
    );
  }

  Iterable<Widget> getSuggestion(SearchController searchController) {
    return [];
    //final String input = searchController.value.text;
    // return Colors.values
    //     .where((ColorLabel color) => color.label.contains(input))
    //     .map(
    //       (ColorLabel filteredColor) => ListTile(
    //         leading: CircleAvatar(backgroundColor: filteredColor.color),
    //         title: Text(filteredColor.label),
    //         trailing: IconButton(
    //           icon: const Icon(Icons.call_missed),
    //           onPressed: () {
    //             controller.text = filteredColor.label;
    //             controller.selection =
    //                 TextSelection.collapsed(offset: controller.text.length);
    //           },
    //         ),
    //         onTap: () {
    //           controller.closeView(filteredColor.label);
    //           handleSelection(filteredColor);
    //         },
    //       ),
    //     );
  }
}
