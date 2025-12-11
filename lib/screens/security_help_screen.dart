import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFF8FAFC),
        appBar: AppBar(
          title: Text('المساعدة والدعم', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Color(0xFF2C3E50),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHelpSection('كيفية استخدام التطبيق', [
                _buildHelpItem(
                  'التنبيهات والإشعارات',
                  'يقوم التطبيق بإرسال تنبيهات في حالة وجود احتمالية لحدوث سيول في منطقتك. تأكد من تفعيل الإشعارات في إعدادات التطبيق.',
                  Icons.notifications_active,
                ),
                _buildHelpItem(
                  'خريطة المخاطر',
                  'استخدم خريطة المخاطر لمعرفة المناطق المعرضة للسيول. اللون الأحمر يشير إلى مخاطر عالية، البرتقالي متوسطة، والأخضر منخفضة.',
                  Icons.map,
                ),

                _buildHelpItem(
                  'إرشادات الأمان',
                  'اطلع على إرشادات الأمان وخطط الإخلاء المقترحة في حالات الطوارئ.',
                  Icons.health_and_safety,
                ),
              ]),
              SizedBox(height: 24),
              _buildHelpSection('الإجراءات في حالات الطوارئ', [
                _buildHelpItem(
                  'قبل حدوث السيول',
                  'تابع نشرات الأرصاد وتنبيهات التطبيق، وجهز حقيبة طوارئ تحتوي على مستلزمات أساسية وأدوية ووثائق مهمة.',
                  Icons.access_time,
                ),
                _buildHelpItem(
                  'أثناء حدوث السيول',
                  'ابتعد فوراً عن مجاري الأودية والمناطق المنخفضة، ولا تحاول عبور مناطق تجمع المياه مهما كان عمقها.',
                  Icons.warning,
                ),
                _buildHelpItem(
                  'بعد انحسار السيول',
                  'تأكد من سلامة المكان قبل العودة إليه، وتجنب لمس الأسلاك الكهربائية المبللة.',
                  Icons.restore,
                ),
              ]),
              SizedBox(height: 24),
              _buildEmergencyContactsCard(),
              SizedBox(height: 24),
              _buildFAQSection(),
              SizedBox(height: 24),
              _buildContactUsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHelpSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        SizedBox(height: 16),
        ...items,
      ],
    );
  }

  Widget _buildHelpItem(String title, String content, IconData icon) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 16),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Color(0xFFE2E8F0)),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: Color(0xFF2C3E50)),
                ),
                SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              content,
              style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyContactsCard() {
    return Card(
      elevation: 0,
      color: Color(0xFFFEF2F2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Color(0xFFFECACA)),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.emergency, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  'أرقام الطوارئ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildEmergencyContact('الدفاع المدني', '191'),
            Divider(color: Colors.red[100]),
            _buildEmergencyContact(' النجدة', '199'),
            Divider(color: Colors.red[100]),
            _buildEmergencyContact(' الإسعاف', '195'),
            Divider(color: Colors.red[100]),
            _buildEmergencyContact(' حوادث المرور', '194'),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyContact(String name, String number) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: TextStyle(fontSize: 16, color: Colors.grey[800])),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.red[300]!),
            ),
            child: Row(
              children: [
                Icon(Icons.phone, size: 16, color: Colors.red),
                SizedBox(width: 4),
                Text(
                  number,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Color(0xFFE2E8F0)),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.question_answer, color: Color(0xFF2C3E50)),
                SizedBox(width: 8),
                Text(
                  'الأسئلة الشائعة',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildFaqItem(
              'كيف يعمل نظام التنبؤ بالسيول؟',
              'يستخدم النظام بيانات الأرصاد الجوية ونماذج رياضية متقدمة للتنبؤ باحتمالية حدوث سيول في مناطق محددة، مع مراعاة طبيعة التضاريس وكميات الأمطار المتوقعة.',
            ),
            _buildFaqItem(
              'هل التطبيق يعمل بدون إنترنت؟',
              'يحتاج التطبيق للاتصال بالإنترنت للحصول على أحدث البيانات والتنبيهات، لكن بعض المعلومات الأساسية مثل إرشادات الأمان متاحة دون اتصال.',
            ),
            _buildFaqItem(
              'هل يمكنني الإبلاغ عن سيول في منطقتي؟',
              'نعم، يمكنك استخدام خاصية "الإبلاغ عن حالة طارئة" في الصفحة الرئيسية لإرسال معلومات عن السيول أو مخاطر أخرى في منطقتك.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Color(0xFF2C3E50),
        ),
      ),
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(answer, style: TextStyle(color: Color(0xFF64748B))),
        ),
      ],
    );
  }

  Widget _buildContactUsSection() {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Color(0xFFE2E8F0)),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.support_agent, color: Colors.green[700]),
                SizedBox(width: 8),
                Text(
                  'تواصل معنا',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildContactItem(
              'البريد الإلكتروني',
              'support@floodapp.gov.sa',
              Icons.email,
            ),
            _buildContactItem('رقم الدعم الفني', '8001234567', Icons.phone),
            _buildContactItem(
              'ساعات العمل',
              'على مدار الساعة طوال أيام الأسبوع',
              Icons.access_time,
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.message),
                label: Text('إرسال ملاحظات'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2C3E50),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(String title, String content, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.green[700], size: 20),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Color(0xFF64748B), fontSize: 12),
              ),
              Text(
                content,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
