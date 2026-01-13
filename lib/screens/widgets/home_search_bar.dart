import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google/controllers/home_controller.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Positioned(
      top: 10,
      left: 16,
      right: 16,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Theme.of(context).dividerColor, width: 1.5),
          color: Theme.of(context).cardColor.withOpacity(0.95),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          focusNode: controller.searchFocusNode,
          onChanged: controller.updateSearchQuery,
          decoration: InputDecoration(
            hintText: 'search'.tr,
            hintStyle: TextStyle(color: Colors.grey.shade600),
            prefixIcon: const Icon(
              Icons.search,
              color: Color(0xFF64748B),
              size: 24,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(
              top: 12,
              right: 12,
              bottom: 12,
            ),
          ),
        ),
      ),
    );
  }
}
