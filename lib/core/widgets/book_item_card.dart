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
    // No need for extra event dispatching here.
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.books.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BookDetails(bookModel: widget.books[index]),
              ),
            );
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Texts.bodyText(widget.books[index].title),
                          ),
                          Flexible(
                            child: Texts.caption("Author"),
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
                          if (state1 is BookIsFavorite) {
                            return InkWell(
                              onTap: () {
                                context.read<FavoriteBloc>().add(
                                      state1.isFavorite
                                          ? RemoveBookFromFavorites(
                                              widget.books[index])
                                          : AddBookToFavorites(
                                              widget.books[index]),
                                    );
                              },
                              child: Image(
                                image: AssetImage(
                                  state1.isFavorite
                                      ? 'assets/images/heart.png'
                                      : 'assets/images/heart-outline.png',
                                ),
                              ),
                            );
                          } else if (state1 is FavoriteLoaded) {
                            return InkWell(
                              onTap: () {
                                context.read<FavoriteBloc>().add(
                                      state1.isFavorite
                                          ? RemoveBookFromFavorites(
                                              widget.books[index])
                                          : AddBookToFavorites(
                                              widget.books[index]),
                                    );
                              },
                              child: Image(
                                image: AssetImage(
                                  state1.isFavorite
                                      ? 'assets/images/heart.png'
                                      : 'assets/images/heart-outline.png',
                                ),
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
              const Divider(),
            ],
          ),
        );
      },
    );
  }
}
