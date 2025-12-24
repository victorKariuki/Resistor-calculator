import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A consistent AppBar with back button for all pages
class AppBarBack extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;

  const AppBarBack({
    super.key,
    required this.title,
    this.actions,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: automaticallyImplyLeading
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                // Use GoRouter's canPop() and pop() methods
                if (context.canPop()) {
                  context.pop();
                } else {
                  // Fallback to home if no route to pop
                  context.go('/home');
                }
              },
            )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

