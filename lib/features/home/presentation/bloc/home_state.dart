part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeAllUsersFetchLoading extends HomeState {}

final class HomeAllUsersFetchFailure extends HomeState {
  final String message;
  HomeAllUsersFetchFailure(this.message);
}

final class HomeAllUsersFetchSuccess extends HomeState {
  final GetAllUserEntity allUsersData;
  
  HomeAllUsersFetchSuccess(this.allUsersData);
}
