import 'package:flutter/material.dart';

class SecurityHelpScreen extends StatelessWidget {
  const SecurityHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        appBar: AppBar(
          title: const Text('الأمان والمساعدة'),
          backgroundColor: const Color(0xFF1E3A8A),
          foregroundColor: Colors.white,
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildOptionCard(
              icon: Icons.security,
              title: 'إعدادات الأمان',
              subtitle: 'قم بتحديث إعدادات الأمان الخاصة بك.',
              onTap: () {},
            ),
            const SizedBox(height: 16),
            _buildOptionCard(
              icon: Icons.support_agent,
              title: 'المساعدة والدعم',
              subtitle: 'تواصل مع فريق الدعم أو اقرأ الأسئلة الشائعة.',
              onTap: () {},
            ),
            const SizedBox(height: 32),
            _buildSectionTitle('معلومات الأمان'),
            const SizedBox(height: 12),
            _buildBulletPoint('حافظ على سرية معلوماتك الشخصية.'),
            _buildBulletPoint('لا تشارك كلمة المرور مع أي شخص.'),
            _buildBulletPoint('في حال وجود مشكلة أمنية، تواصل مع الدعم فوراً.'),
            const SizedBox(height: 32),
            _buildSectionTitle('للمساعدة والدعم'),
            const SizedBox(height: 12),
            _buildBulletPoint('يمكنك التواصل مع فريق الدعم عبر البريد الإلكتروني أو الهاتف.'),
            _buildBulletPoint('راجع قسم الأسئلة الشائعة للمزيد من المعلومات.'),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A8A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              ),
              onPressed: () {
                // افتح صفحة تواصل أو دعم
              },
              icon: const Icon(Icons.email, color: Colors.white),
              label: const Text(
                'تواصل مع الدعم الآن',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF1E3A8A).withOpacity(0.1),
          child: Icon(icon, color: const Color(0xFF1E3A8A)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Color(0xFF1E3A8A),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ",
              style: TextStyle(fontSize: 20, color: Color(0xFF1E3A8A))),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
