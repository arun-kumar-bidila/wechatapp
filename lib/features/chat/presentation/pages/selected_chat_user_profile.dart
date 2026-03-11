import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wechat/common/entities/user.dart';
import 'package:wechat/common/theme/app_colors.dart';
import 'package:wechat/features/chat/domain/entities/message_entity.dart';

class SelectedChatUserProfile extends StatefulWidget {
  final User selectedUser;
  final List<MessageEntity>? messages;

  const SelectedChatUserProfile({
    super.key,
    required this.selectedUser,
    required this.messages,
  });

  @override
  State<SelectedChatUserProfile> createState() =>
      _SelectedChatUserProfileState();
}

class _SelectedChatUserProfileState extends State<SelectedChatUserProfile> {
  List<String> images = [];

  @override
  void initState() {
    super.initState();
    if (widget.messages == null) return;

    images = widget.messages!
        .where((message) => message.image != null)
        .map((message) => message.image!)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: Center(
          child: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded, size: 24),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: 'user-profile-${widget.selectedUser.id}',
                child: widget.selectedUser.profilePic.isEmpty
                    ? Container(
                        width: 60,
                        height: 60,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.surfaceContainer,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/profile.svg",
                          fit: BoxFit.contain,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.secondary,
                            BlendMode.srcIn,
                          ),
                        ),
                      )
                    : SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipOval(
                          child: Image.network(
                            widget.selectedUser.profilePic,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ),
              SizedBox(height: 24),
              Text(
                widget.selectedUser.fullName,
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              Text(
                '${widget.selectedUser.bio} 😊',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 24),
              Container(height: 1, color: AppColors.greyColor),
              SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Media 📷',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),

              if (images.isEmpty) ...[
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('No files yet !',style: Theme.of(context).textTheme.bodySmall,)),
              ],

              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final image = images[index];

                  return ClipRRect(
                    child: Image.network(image, fit: BoxFit.cover),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
