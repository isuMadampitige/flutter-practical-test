import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical_test/core/constants/constants.dart';
import 'package:flutter_practical_test/features/book/data/models/book_model.dart';
import 'package:flutter_practical_test/features/book_details/presentaion/bloc/book_details_bloc.dart';
import 'package:flutter_practical_test/features/theme/bloc/theme_bloc.dart';
import 'package:flutter_practical_test/injection_container.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/widgets/dialogs.dart';
import '../../../../core/widgets/texts/common_texts.dart';
import '../../../theme/bloc/theme_event.dart';
import '../bloc/book_details_event.dart';
import '../bloc/book_details_state.dart';

class BookDetails extends StatefulWidget {
  final BookModel? bookModel;
  const BookDetails({super.key, this.bookModel});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: Texts.subheading("Book Details"),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Constants.medium),
              child: InkWell(
                onTap: () {
                  context.read<ThemeBloc>().add(ToggleThemeEvent());
                },
                child: SvgPicture.asset(
                  'assets/images/moon1.svg',
                  height: 30.0,
                  width: 30.0,
                  color: Colors.white,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) => locator<BookDetaisBloc>()
          ..add(OnBookDetails(widget.bookModel!.isbn13)),
        child: BlocConsumer<BookDetaisBloc, BookDetailState>(
          listener: (context, state) {
            if (state is BookDetailLoading) {
              showLoadingDialog(context);
            } else if (state is BooBookDetailError) {
              hideLoadingDialog(context);
              showDialogMsg(context, state.message, "Information");
            } else if (state is BookDetailLoaded) {
              hideLoadingDialog(context);
            }
          },
          builder: (context, state) {
            if (state is BookDetailInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is BookDetailLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Constants.medium, horizontal: Constants.large),
                child: SizedBox(
                  width: size.width,
                  height: size.height - 60,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            widget.bookModel!.image,
                            fit: BoxFit.fill,
                            width: size.width * 0.6,
                            height: MediaQuery.sizeOf(context).height * 0.32,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                              child: Texts.subheading2(state.result.title)),
                          const SizedBox(width: Constants.small),
                          Texts.heading2(state.result.price),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            // height: size.height * 0.2,
                            width: size.width * 0.8,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                        child: Texts.caption(
                                            state.result.authors)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: Constants.small,
                      ),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: double.parse(state.result.rating),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                            itemSize: 30,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: Constants.large,
                      ),
                      Row(
                        children: [
                          Flexible(child: Texts.bodyText(state.result.desc)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
