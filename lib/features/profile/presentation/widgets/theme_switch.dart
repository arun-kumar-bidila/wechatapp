import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wechat/common/theme/theme_cubit.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.dark_mode_rounded, size: 25),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Chat Theme", style: Theme.of(context).textTheme.bodyMedium),

              Text(
                "Change your chat theme",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          Spacer(),
          Switch(
            value: context.watch<ThemeCubit>().state == ThemeMode.dark,
            onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
          ),
        ],
      ),
    );
  }
}
