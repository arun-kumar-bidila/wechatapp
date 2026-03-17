// part of 'home_bloc.dart';

// @immutable
// sealed class HomeState {}

// final class HomeInitial extends HomeState {}

// final class HomeAllUsersFetchLoading extends HomeState {}

// final class HomeAllUsersFetchFailure extends HomeState {
//   final String message;
//   HomeAllUsersFetchFailure(this.message);
// }

// final class HomeAllUsersFetchSuccess extends HomeState {
//   final GetAllUserEntity allUsersData;

//   HomeAllUsersFetchSuccess(this.allUsersData);
// }

part of 'home_bloc.dart';

@immutable
class HomeState {
  final bool isLoading;
  final String? error;
  final GetAllUserEntity? allUsersData;
  final List<dynamic> onlineUsers;

  const HomeState({
    this.isLoading = false,
    this.error,
    this.allUsersData,
    this.onlineUsers = const [],
  });

  HomeState copyWith({
    bool? isLoading,
    String? error,
    GetAllUserEntity? allUsersData,
    List<dynamic>? onlineUsers,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      allUsersData: allUsersData ?? this.allUsersData,
      onlineUsers: onlineUsers ?? this.onlineUsers,
    );
  }

  factory HomeState.initial() {
    return const HomeState(
      isLoading: false,
      error: null,
      allUsersData: null,
      onlineUsers: [],
    );
  }
}
