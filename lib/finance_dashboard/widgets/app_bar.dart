import 'package:flutter/material.dart';

class FinanceAppBar extends StatelessWidget {
  const FinanceAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Hi, Alex'),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none_rounded),
          onPressed: () {},
        ),
        const CircleAvatar(
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
