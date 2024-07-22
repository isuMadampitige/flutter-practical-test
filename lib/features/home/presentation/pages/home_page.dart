import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical_test/core/constants/constants.dart';
import 'package:flutter_practical_test/core/widgets/dialogs.dart';
import 'package:flutter_practical_test/features/book/presentation/bloc/book_bloc.dart';
import 'package:flutter_practical_test/features/book/presentation/bloc/book_state.dart';
import 'package:flutter_practical_test/injection_container.dart';
import '../../../../core/widgets/book_item_card.dart';
import '../../../../core/widgets/common_text_field.dart';
import '../../../book/presentation/bloc/book_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String _currentQuery = "";

  void onScroll() {
    print('at bottom');
    if (_scrollController.position.atEdge) {
      context.read<BookBloc>().add(NextPage());
    }
  }

  onSearchChanged(String value) {
    final query = value;
    print(query);

    if (query != _currentQuery) {
      _currentQuery = query;
      context.read<BookBloc>().add(ResetItems());
      context.read<BookBloc>().add(OnSearchQuery(_currentQuery, 1));
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      onScroll();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Constants.medium, horizontal: Constants.medium),
            child: Column(
              children: [
                const SizedBox(
                  height: Constants.large,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: CommonTextField(
                          labelText: 'Search',
                          controller: _searchController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onchange: (value) {
                            onSearchChanged(value!);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: Constants.medium,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/favorites');
                      },
                      child: const Image(
                        image: AssetImage('assets/images/heart.png'),
                      ),
                    )
                  ],
                ),
                BlocProvider(
                  create: (context) =>
                      locator<BookBloc>()..add(OnSearchQuery(_currentQuery, 1)),
                  child: BlocConsumer<BookBloc, BookState>(
                    listener: (context, state) {
                      FocusScope.of(context).unfocus();
                      print(state);
                      if (state is BookLoading) {
                        showLoadingDialog(context);
                      } else if (state is BookError) {
                        hideLoadingDialog(context);
                        showDialogMsg(context, state.message, "Information");
                      } else if (state is BookLoaded) {
                        hideLoadingDialog(context);
                      } else if (state is BookEmpty) {
                        hideLoadingDialog(context);
                      }
                    },
                    builder: (context, state) {
                      if (state is BookLoaded) {
                        return Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            shrinkWrap: true,
                            itemCount: state.result.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              if (index >= state.result.length) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return BookItemCard(
                                  bookModel: state.result[index]);
                            },
                          ),
                        );
                      } else if (state is BookEmpty) {
                        return const Expanded(
                            child: Center(child: Text("No Data")));
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
