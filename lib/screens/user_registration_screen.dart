import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';

class UserRegistrationScreen extends StatefulWidget {
  final String phoneNumber;

  const UserRegistrationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _passController = TextEditingController();
  final _cityController = TextEditingController();
  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Directionality( // جعل كل الصفحة RTL
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFF60A5FA),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF1E3A8A),
                Color(0xFF3B82F6),
                Color(0xFF60A5FA),
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.person_add,
                        size: 50,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                    const SizedBox(height: 32),

                    const Text(
                      'إكمال التسجيل',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      'أدخل بياناتك الشخصية',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    // الاسم
                    _buildTextField(
                      controller: _nameController,
                      hint: 'الاسم الكامل',
                      icon: Icons.person,
                      validator: (value) =>
                          value!.isEmpty ? 'الرجاء إدخال الاسم' : null,
                    ),
                    const SizedBox(height: 20),

                    // العنوان
                    _buildTextField(
                      controller: _addressController,
                      pass: true,
                      hint: ' كلمة السر',
                      icon: Icons.lock,
                      validator: (value) =>
                          value!.isEmpty ? 'الرجاء إدخال كلمة السر ' : null,
                    ),
              
                    const SizedBox(height: 20),
                    _buildTextField(
                      pass: true,
                      controller: _passController,
                      hint: ' تاكيد كلمة السر',
                      icon: Icons.lock_outline,
                      validator: (value) =>
                          value!.isEmpty ? 'الرجاء إدخال تاكيد كلمة السر ' : null,
                    ),
                    const SizedBox(height: 20),
  const SizedBox(height: 15),
                    // المدينة

                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _completeRegistration,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF1E3A8A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF1E3A8A),
                                ),
                              )
                            : const Text(
                                'إكمال التسجيل',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool  pass = false,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: _boxDecoration(),
      child: TextFormField(
        obscureText: pass,
        controller: controller,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl, // النص ومؤشر الماوس RTL
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          prefixIcon: Icon(icon, color: const Color(0xFF1E3A8A)),
        ),
        validator: validator,
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }

  void _completeRegistration() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _isLoading = false);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    super.dispose();
  }
}
