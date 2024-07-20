import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical_test/features/home/presentation/bloc/home_event.dart';
import 'package:flutter_practical_test/features/home/presentation/bloc/home_state.dart';

import '../../domain/usecases/search_books.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SearchBooks searchBooks;

  HomeBloc(this.searchBooks) : super(HomeEmpty()) {
    on<AppStarted>(_mapEventToState);
  }

  void _mapEventToState(AppStarted event, Emitter<HomeState> emit) async {
    await Future.delayed(const Duration(seconds: 2));

    emit(HomeLoaded());
  }
}
