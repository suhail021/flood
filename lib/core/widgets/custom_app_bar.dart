import 'package:flutter/material.dart';

AppBar buildAppBar(
  BuildContext context, {
  required String title,
  bool showBackIcon = true,
  bool showactionsIcon = false,
  void Function()? onPressed,
}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    foregroundColor: Colors.white,
    elevation: 0,
    actions: [
      IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.notifications, color: Colors.white),
      ),
    ],
  );
}
