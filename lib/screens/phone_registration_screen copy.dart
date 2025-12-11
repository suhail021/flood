import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google/screens/phone_login_screen.dart';
import 'phone_verification_screen.dart';
import 'package:google/widgets/custom_text_form_field.dart';

class PhoneRegistrationScreen extends StatefulWidget {
  const PhoneRegistrationScreen({super.key});

  @override
  State<PhoneRegistrationScreen> createState() =>
      _PhoneRegistrationScreenState();
}

class _PhoneRegistrationScreenState extends State<PhoneRegistrationScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
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
          child: Padding(
            padding: const EdgeInsets.only(top: 2.0, right: 24, left: 24),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // شعار التطبيق
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        width: 210,
                        height: 210,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Image.asset('assets/images/logo.png'),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // عنوان التطبيق
                    const Text(
                      'إنشاء حساب الان',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),

                    const Text(
                      'أدخل رقم هاتفك للبدء',
                      style: TextStyle(fontSize: 16, color: Color(0xFF64748B)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),

                    // حقل إدخال رقم الهاتف
                    CustomTextFormField(
                      controller: _phoneController,
                      hintText: 'رقم الهاتف',
                      prefixIcon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال رقم الهاتف';
                        }
                        if (value.length < 9) {
                          return 'رقم الهاتف غير صحيح';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    // زر إرسال رمز التحقق
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _sendVerificationCode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2C3E50),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
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
                                  'إرسال رمز التحقق',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // زر الاتصال المباشر
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhoneLoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'لدي حساب بالفعل ',
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 16,
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

  void _sendVerificationCode() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // محاكاة إرسال رمز التحقق
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // الانتقال إلى صفحة التحقق
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  PhoneVerificationScreen(phoneNumber: _phoneController.text),
        ),
      );
    }
  }

  void _callEmergency() async {
    try {
      await FlutterPhoneDirectCaller.callNumber('911');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('حدث خطأ في الاتصال'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}
