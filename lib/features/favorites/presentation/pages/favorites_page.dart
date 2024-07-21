import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical_test/core/constants/constants.dart';
import 'package:flutter_practical_test/features/favorites/presentation/bloc/favorite_event.dart';
import '../../../../core/widgets/book_item_card.dart';
import '../../../../core/widgets/dialogs.dart';
import '../../../../core/widgets/texts/common_texts.dart';
import '../../../../injection_container.dart';
import '../bloc/favorite_bloc.dart';
import '../bloc/favorite_state.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          locator<FavoriteBloc>()..add(const LoadFavoriteBooks(false)),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            title: Texts.subheading("Favorites"),
            centerTitle: true,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Constants.small, horizontal: Constants.small),
          child: BlocConsumer<FavoriteBloc, FavoriteState>(
            listener: (context, state) {
              print(state);
              if (state is FavoriteLoading) {
                showLoadingDialog(context);
              } else if (state is FavoriteError) {
                hideLoadingDialog(context);
                showDialogMsg(context, state.message, "Information");
              } else if (state is FavoriteLoaded) {
                hideLoadingDialog(context);
              }
            },
            builder: (context, state) {
              if (state is FavoriteLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FavoriteLoaded) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height - 60,
                    child: BookItemCard(books: state.result));
              } else {
                return const Center(
                  child: Text("No Favorites Found."),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
