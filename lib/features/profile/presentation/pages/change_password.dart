
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        ),
        title: Text('Change Password',style:Theme.of(context).textTheme.titleMedium,),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Currently this feature is not available',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
