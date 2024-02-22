part of '../page.dart';

/// Widget for displaying a search bar.
class BoxSearch extends StatelessWidget {
  BoxSearch({
    super.key,
  });

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: 'Writte a promt here...',
      controller: searchController,
      backgroundColor:
          MaterialStateProperty.resolveWith((states) => Colors.white),
      elevation: MaterialStateProperty.resolveWith((states) => 1),
      trailing: [
        IconButton(
          icon: const Icon(Icons.send_rounded),
          onPressed: () {
            BlocProvider.of<GenerativeAIBloc>(context).add(
              OnGenerativeAIText(
                prompt: searchController.text.trim(),
              ),
            );
          },
        )
      ],
      onSubmitted: (value) {
        BlocProvider.of<GenerativeAIBloc>(context).add(
          OnGenerativeAIText(
            prompt: searchController.text.trim(),
          ),
        );
      },
    );
  }
}
