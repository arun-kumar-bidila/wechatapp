import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wechat/common/cubit/app_user/app_user_cubit.dart';
import 'package:wechat/common/entities/user.dart';
import 'package:wechat/common/theme/app_colors.dart';
import 'package:wechat/common/widgets/loader.dart';
import 'package:wechat/features/home/presentation/bloc/home_bloc.dart';
import 'package:wechat/features/home/presentation/widgets/chat_tile.dart';
import 'package:wechat/features/home/presentation/widgets/profile_skeleton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<User> filteredUsers = [];
  List<String> filterCategories = ['All', 'Online', 'Offline', 'Unread'];
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();

    context.read<HomeBloc>().add(HomeOnFetchAllUsers());
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {});
  }

  Future<void> _refreshUsers() async {
    context.read<HomeBloc>().add(HomeOnFetchAllUsers());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<User> applyFilters(HomeState state) {
    if (state.allUsersData == null) return [];
    List<User> users = state.allUsersData!.users;
    // Apply category filter
    if (selectedCategory == 'Online') {
      users = users
          .where((user) => state.onlineUsers.contains(user.id))
          .toList();
    } else if (selectedCategory == 'Offline') {
      users = users
          .where((user) => !state.onlineUsers.contains(user.id))
          .toList();
    } else if (selectedCategory == 'Unread') {
      users = users.where((user) {
        final unseenCount = state.allUsersData!.unseen[user.id] ?? 0;
        return unseenCount > 0;
      }).toList();
    }

    // Apply search filter
    final query = _searchController.text.toLowerCase();

    if (query.isNotEmpty) {
      users = users.where((user) {
        return user.fullName.toLowerCase().contains(query);
      }).toList();
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        actionsPadding: EdgeInsets.only(right: 16),

        leading: Center(
          child: GestureDetector(
            onTap: () {
              context.push('/profile');
            },
            child: BlocBuilder<AppUserCubit, AppUserState>(
              builder: (context, state) {
                if (state is AppUserLoggedIn) {
                  return Hero(
                    tag: 'location-profile',
                    child: state.user.profilePic.isEmpty
                        ? Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.only(left: 16),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainer,
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/profile.svg",
                              width: 18,
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.secondary,
                                BlendMode.srcIn,
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: ClipOval(
                                child: Image.network(
                                  state.user.profilePic,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }

                                        return ProfileSkeleton(
                                          width: 40,
                                          height: 40,
                                        );
                                      },
                                ),
                              ),
                            ),
                          ),
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ),
        title: Text("Message", style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
        actions: [
          Center(
            child: Container(
              padding: EdgeInsets.all(8),

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
              child: Icon(
                Icons.notifications_none,
                size: 24,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/search.svg",
                      width: 16,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.secondary,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Search People",
                          hintStyle: Theme.of(context).textTheme.bodySmall,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: filterCategories.length,

                        itemBuilder: (context, index) {
                          final filterCategoryTitle = filterCategories[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedCategory == filterCategoryTitle) {
                                  selectedCategory = 'All';
                                } else {
                                  selectedCategory = filterCategoryTitle;
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: selectedCategory == filterCategoryTitle
                                    ? AppColors.appColor
                                    : null,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppColors.borderColor,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  filterCategoryTitle,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  backgroundColor: AppColors.white,
                  color: AppColors.appColor,
                  onRefresh: _refreshUsers,
                  child: BlocConsumer<HomeBloc, HomeState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state.isLoading) {
                        return Loader();
                      }
                      if (state.allUsersData != null) {
                        final users = applyFilters(state);
                        return ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final unseenCount =
                                state.allUsersData!.unseen[users[index].id] ??
                                0;
                            final onlineStatus = state.onlineUsers.contains(
                              users[index].id,
                            );
                            return ChatTile(
                              user: users[index],
                              unseenCount: unseenCount,
                              onlineStatus: onlineStatus,
                            );
                          },
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
