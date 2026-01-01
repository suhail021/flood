import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google/core/utils/app_images.dart';
import 'package:google/core/utils/app_text_styles.dart';

AppBar buildAppBar(
  BuildContext context, {
  required String title,
  bool showBackIcon = true,
  bool showactionsIcon = false,
}) {
  return AppBar(
    backgroundColor:
        Theme.of(context).appBarTheme.backgroundColor ?? Colors.transparent,
    automaticallyImplyLeading: false,
    leading:
        showBackIcon
            ? GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                color:
                    Theme.of(context).iconTheme.color ??
                    Theme.of(context).colorScheme.onSurface,
              ),
            )
            : null,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyles.bold19.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
    ),
    actions:
        showactionsIcon
            ? [
              Container(
                padding: EdgeInsets.all(10),
                decoration: ShapeDecoration(
                  shape: OvalBorder(),
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                ),
                child: SvgPicture.asset(
                  Assets.imagesNotification,
                  // ignore: deprecated_member_use
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ]
            : null,
  );
}
