import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google/core/utils/app_colors.dart';

class FAQSection extends StatelessWidget {
  const FAQSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 0,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDark ? Colors.white12 : const Color(0xFFE2E8F0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.question_answer,
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? AppColors.textSecondary
                          : Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'faq'.tr,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildFaqItem('faq_q1'.tr, 'faq_a1'.tr),
            _buildFaqItem('faq_q2'.tr, 'faq_a2'.tr),
            _buildFaqItem('faq_q3'.tr, 'faq_a3'.tr),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Builder(
      builder:
          (context) => ExpansionTile(
            title: Text(
              question,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Theme.of(context).textTheme.titleMedium?.color,
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(
                  answer,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
