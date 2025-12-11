import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'phone_login_screen.dart';
import 'package:google/widgets/custom_text_form_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  bool _isEditing = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('user_name') ?? 'أحمد محمد';
      _addressController.text =
          prefs.getString('user_address') ?? 'شارع الجمهورية، صنعاء';
      _cityController.text = prefs.getString('user_city') ?? 'صنعاء';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFF8FAFC),
        appBar: AppBar(
          title: const Text(
            'الملف الشخصي',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF2C3E50),
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
              tooltip: _isEditing ? ' حفظ' : 'تعديل',

              icon: Icon(_isEditing ? Icons.done : Icons.edit),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // صورة الملف الشخصي
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(60),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // اسم المستخدم
                  Text(
                    _nameController.text,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  Text(
                    'مستخدم نشط',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF64748B),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // معلومات المستخدم
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // حقل الاسم
                        _buildInfoField(
                          label: 'الاسم الكامل',
                          icon: Icons.person,
                          controller: _nameController,
                          enabled: _isEditing,
                        ),
                        const SizedBox(height: 20),
                        _buildInfoField(
                          label: 'رقم الهاتف',
                          icon: Icons.phone,
                          controller: _passController,
                          enabled: _isEditing,
                        ),
                        const SizedBox(height: 20),

                        // إحصائيات
                        if (!_isEditing) ...[],
                      ],
                    ),
                  ),

                  // أزرار إضافية
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required bool enabled,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 8),
        CustomTextFormField(
          controller: controller,
          enabled: enabled,
          hintText: label,
          prefixIcon: icon,
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFF2C3E50).withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(icon, color: const Color(0xFF2C3E50), size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFF2C3E50).withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(icon, color: const Color(0xFF2C3E50), size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 14, color: Color(0xFF64748B)),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Color(0xFF2C3E50),
          size: 20,
        ),
      ),
    );
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // محاكاة حفظ البيانات
      await Future.delayed(const Duration(seconds: 2));

      // حفظ البيانات في SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', _nameController.text);
      await prefs.setString('user_address', _addressController.text);
      await prefs.setString('user_city', _cityController.text);

      setState(() {
        _isLoading = false;
        _isEditing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم حفظ التغييرات بنجاح'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _cancelEdit() {
    setState(() {
      _isEditing = false;
    });
    _loadUserData(); // إعادة تحميل البيانات الأصلية
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تسجيل الخروج'),
          content: const Text('هل أنت متأكد من تسجيل الخروج؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () async {
                // مسح بيانات المستخدم
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();

                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PhoneLoginScreen(),
                  ),
                  (route) => false,
                );
              },
              child: const Text('تأكيد'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    super.dispose();
  }
}
