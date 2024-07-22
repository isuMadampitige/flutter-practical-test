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
  final BookModel bookModel;

  const BookItemCard({Key? key, required this.bookModel}) : super(key: key);

  @override
  State<BookItemCard> createState() => _BookItemCardState();
}

class _BookItemCardState extends State<BookItemCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetails(bookModel: widget.bookModel),
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
                  widget.bookModel.image,
                  fit: BoxFit.fill,
                  width: size.width * 0.33,
                  height: MediaQuery.sizeOf(context).height * 0.15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Texts.bodyText(widget.bookModel.title),
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
                    ..add(CheckIfBookIsFavorite(widget.bookModel)),
                  child: BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (context, state1) {
                      if (state1 is BookIsFavorite) {
                        return InkWell(
                          onTap: () {
                            context.read<FavoriteBloc>().add(
                                  state1.isFavorite
                                      ? RemoveBookFromFavorites(
                                          widget.bookModel)
                                      : AddBookToFavorites(widget.bookModel),
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
                                          widget.bookModel)
                                      : AddBookToFavorites(widget.bookModel),
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
  }
}
