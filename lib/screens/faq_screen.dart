import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/screens/widgets/faq_section.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        leading: IconButton(
          highlightColor: Colors.transparent,
          padding: EdgeInsets.only(right: 24, left: 24),
          onPressed: Get.back,
          icon: Icon(Icons.arrow_back_ios, size: 22),
        ),
        centerTitle: true,
        title: Text(
          'faq_title'.tr,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [FAQSection()],
        ),
      ),
    );
  }
}
