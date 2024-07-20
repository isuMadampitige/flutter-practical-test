import 'package:flutter_practical_test/features/book/presentation/bloc/book_bloc.dart';
import 'package:flutter_practical_test/features/book_details/data/datasources/book_detail_remote.dart';
import 'package:flutter_practical_test/features/book_details/data/repositories/book_detail_repository_impl.dart';
import 'package:flutter_practical_test/features/book_details/domain/repositories/book_details_repository.dart';
import 'package:flutter_practical_test/features/book_details/presentaion/bloc/book_details_bloc.dart';
import 'package:flutter_practical_test/features/favorites/data/repositories/favorite_repository_impl.dart';
import 'package:flutter_practical_test/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:flutter_practical_test/features/favorites/domain/usecases/fetch_favorites.dart';
import 'package:flutter_practical_test/features/favorites/presentation/bloc/favorite_bloc.dart';
import 'package:flutter_practical_test/features/favorites/presentation/bloc/is_favorite_book.dart';
import 'package:flutter_practical_test/features/home/data/datasources/home_remote_datasorce.dart';
import 'package:flutter_practical_test/features/home/data/repositories/home_repository_impl.dart';
import 'package:flutter_practical_test/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_practical_test/features/home/domain/usecases/search_books.dart';
import 'package:flutter_practical_test/features/theme/bloc/theme_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/shared_preferences/shared_preferences_datasorce.dart';
import 'features/book_details/domain/usecases/book_details.dart';
import 'features/favorites/domain/usecases/add_favorite_books.dart';
import 'features/favorites/domain/usecases/remove_favorite_books.dart';
import 'features/home/presentation/bloc/home_bloc.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  // Bloc
  locator.registerFactory(() => ThemeBloc());
  locator.registerFactory(() => HomeBloc(locator()));
  locator.registerLazySingleton(() => BookBloc(locator()));
  locator.registerFactory(() => FavoriteBloc(
      addFavoriteBook: locator(),
      fetchFavorites: locator(),
      removeFavoriteBook: locator(),
      checkIfBookIsFavoriteUseCase: locator()));

  locator.registerFactory(() => BookDetaisBloc(locator()));

  // Use cases
  locator.registerLazySingleton(() => SearchBooks(locator()));
  locator.registerLazySingleton(() => BookDetailsFetch(locator()));
  locator.registerLazySingleton(() => FetchFavorites(locator()));
  locator.registerLazySingleton(() => AddFavoriteBook(locator()));
  locator.registerLazySingleton(() => RemoveFavoriteBook(locator()));
  locator.registerLazySingleton(() => CheckIfBookIsFavoriteUseCase(locator()));

  // Repository
  locator.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<BookDetailsRepository>(
    () => BookDetailsRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<FavoritesRepository>(
    () => FavoriteRepositoryImpl(sharedPreferences: locator()),
  );

  // Data sources
  locator.registerLazySingleton(() => SharedPreferencesDataSource(locator()));
  locator.registerLazySingleton<HomeRemoteDatasorce>(
    () => HomeRemoteDatasorceImpl(),
  );
  locator.registerLazySingleton<BookDetailRemote>(
    () => BookDetailRemoteImpl(),
  );
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
}
