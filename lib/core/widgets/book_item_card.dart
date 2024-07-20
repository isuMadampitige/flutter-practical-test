import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical_test/features/book_details/presentaion/pages/book_details_page.dart';
import 'package:flutter_practical_test/features/book/data/models/book_model.dart';
import 'package:flutter_practical_test/features/favorites/presentation/bloc/favorite_bloc.dart';
import 'package:flutter_practical_test/features/favorites/presentation/bloc/favorite_event.dart';
import 'package:flutter_practical_test/features/favorites/presentation/bloc/favorite_state.dart';
import 'package:flutter_practical_test/injection_container.dart';
import '../constants/constants.dart';
import 'texts/common_texts.dart';

class BookItemCard extends StatefulWidget {
  final List<BookModel> books;

  const BookItemCard({Key? key, required this.books}) : super(key: key);

  @override
  State<BookItemCard> createState() => _BookItemCardState();
}

class _BookItemCardState extends State<BookItemCard> {
  @override
  void didUpdateWidget(BookItemCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) {
      // // Dispatching a remove event for each book in the old widget that is not in the new widget
      oldWidget.books
          .where((book) => !widget.books.contains(book))
          .forEach((book) {
        locator<FavoriteBloc>().add(RemoveBookFromFavorites(book));
      });

      // Dispatching an add event for each book in the new widget that is not in the old widget
      widget.books
          .where((book) => !oldWidget.books.contains(book))
          .forEach((book) {
        locator<FavoriteBloc>().add(AddBookToFavorites(book));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      shrinkWrap: true,
      // itemExtent: MediaQuery.of(context).size.width * 0.5,
      itemCount: widget.books.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookDetails(
                          bookModel: widget.books[index],
                        )));
          },
          child: Column(
            children: [
              SizedBox(
                height: size.width * 0.35,
                child: Row(
                  children: [
                    Image.network(
                      widget.books[index].image,
                      fit: BoxFit.fill,
                      width: size.width * 0.33,
                      height: MediaQuery.sizeOf(context).height * 0.15,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                  child: Texts.bodyText(
                                      widget.books[index].title)),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(child: Texts.caption("Author")),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: Constants.small),
                    BlocProvider(
                      create: (context) => locator<FavoriteBloc>()
                        ..add(CheckIfBookIsFavorite(widget.books[index])),
                      child: BlocBuilder<FavoriteBloc, FavoriteState>(
                        builder: (context, state1) {
                          print(state1);
                          FocusScope.of(context).unfocus();

                          if (state1 is BookIsFavorite) {
                            print(state1.isFavorite);

                            return InkWell(
                              onTap: () {
                                if (!state1.isFavorite) {
                                  context.read<FavoriteBloc>().add(
                                      AddBookToFavorites(widget.books[index]));
                                } else {
                                  context.read<FavoriteBloc>().add(
                                      RemoveBookFromFavorites(
                                          widget.books[index]));
                                }
                              },
                              child: Image(
                                image: state1.isFavorite == true
                                    ? AssetImage('assets/images/heart.png')
                                    : AssetImage(
                                        'assets/images/heart-outline.png'),
                              ),
                            );
                          } else if (state1 is FavoriteLoaded) {
                            print("FavoriteLoaded-${state1.isFavorite}");

                            return InkWell(
                              onTap: () {
                                if (state1.isFavorite == false) {
                                  context.read<FavoriteBloc>().add(
                                      AddBookToFavorites(widget.books[index]));
                                } else {
                                  context.read<FavoriteBloc>().add(
                                      RemoveBookFromFavorites(
                                          widget.books[index]));
                                }
                              },
                              child: Image(
                                image: state1.isFavorite == true
                                    ? AssetImage('assets/images/heart.png')
                                    : AssetImage(
                                        'assets/images/heart-outline.png'),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    )
                  ],
                ),
              ),
              const Divider()
            ],
          ),
        );
      },
    );
  }
}
