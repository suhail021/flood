import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';
import 'package:google/widgets/custom_text_form_field.dart';

class UserRegistrationScreen extends StatefulWidget {
  final String phoneNumber;

  const UserRegistrationScreen({super.key, required this.phoneNumber});

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
    return Directionality(
      // جعل كل الصفحة RTL
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFF8FAFC),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            highlightColor: Colors.transparent,
            padding: EdgeInsets.only(right: 24),
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF2C3E50),
              size: 28,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person_add,
                      size: 50,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  const SizedBox(height: 32),

                  const Text(
                    'إكمال التسجيل',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    'أدخل بياناتك الشخصية',
                    style: TextStyle(fontSize: 16, color: Color(0xFF64748B)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // الاسم
                  CustomTextFormField(
                    controller: _nameController,
                    hintText: 'الاسم الكامل',
                    prefixIcon: Icons.person,
                    validator:
                        (value) => value!.isEmpty ? 'الرجاء إدخال الاسم' : null,
                  ),
                  const SizedBox(height: 20),

                  // العنوان
                  CustomTextFormField(
                    controller: _addressController,
                    obscureText: true,
                    hintText: ' كلمة السر',
                    prefixIcon: Icons.lock,
                    validator:
                        (value) =>
                            value!.isEmpty ? 'الرجاء إدخال كلمة السر ' : null,
                  ),

                  const SizedBox(height: 20),
                  CustomTextFormField(
                    obscureText: true,
                    controller: _passController,
                    hintText: ' تاكيد كلمة السر',
                    prefixIcon: Icons.lock_outline,
                    validator:
                        (value) =>
                            value!.isEmpty
                                ? 'الرجاء إدخال تاكيد كلمة السر '
                                : null,
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
                        backgroundColor: const Color(0xFF2C3E50),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child:
                          _isLoading
                              ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
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
