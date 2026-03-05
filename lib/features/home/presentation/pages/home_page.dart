import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wechat/common/theme/app_colors.dart';
import 'package:wechat/core/utils/socket_service.dart';
import 'package:wechat/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wechat/features/home/presentation/bloc/home_bloc.dart';
import 'package:wechat/features/home/presentation/widgets/chat_tile.dart';
import 'package:wechat/features/home/presentation/widgets/profile_skeleton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _refreshUsers() async {
    context.read<HomeBloc>().add(HomeOnFetchAllUsers());
  }

  @override
  void initState() {
    super.initState();

    final authState = context.read<AuthBloc>().state;

    if (authState is AuthUserLoggedIn) {
      SocketService().connect(authState.user.id, (onlineUsers) {
        debugPrint("Online users: $onlineUsers");
      });
    }
    context.read<HomeBloc>().add(HomeOnFetchAllUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 16),

        leading: Center(
          child: GestureDetector(
            onTap: () {
              context.push('/profile');
            },
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthUserLoggedIn) {
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
                                        if (loadingProgress == null){ return child;}
                                         

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
              Expanded(
                child: RefreshIndicator(
                  backgroundColor: AppColors.white,
                  color: AppColors.appColor,
                  onRefresh: _refreshUsers,
                  child: BlocConsumer<HomeBloc, HomeState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is HomeAllUsersFetchSuccess) {
                        final users = state.allUsers;
                        return ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            return ChatTile(user: users[index]);
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
