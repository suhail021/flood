import 'package:flutter/material.dart';
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
  final _cityController = TextEditingController();
  bool _isLoading = false;

  final List<String> _cities = [
    'صنعاء',
    'عدن',
    'تعز',
    'الحديدة',
    'إب',
    'ذمار',
    'البيضاء',
    'حضرموت',
    'شبوة',
    'مأرب',
    'الجوف',
    'صعدة',
    'عمران',
    'ريمة',
    'أبين',
    'لحج',
    'أب',
    'المحويت',
    'الضالع',
    'بيحان',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF60A5FA),
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
            padding: const EdgeInsets.only(top: 24.0,left: 24.0,right: 24,bottom: 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // زر العودة
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // أيقونة التسجيل
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
                  
                  // عنوان الصفحة
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
                  
                  Text(
                    'أدخل بياناتك الشخصية',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  
                  // حقل الاسم
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _nameController,
                      textAlign: TextAlign.right, // محاذاة النص لليمين
                      decoration: const InputDecoration(
                        hintText: 'الاسم الكامل',
                        hintTextDirection: TextDirection.rtl, // اتجاه النص الظاهر
                        suffixIcon: Icon(Icons.person, color: Color(0xFF1E3A8A)), // تغيير من suffix إلى prefix
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        alignLabelWithHint: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال الاسم';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // حقل العنوان
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _addressController,
                      textAlign: TextAlign.right, // محاذاة النص لليمين
                      decoration: const InputDecoration(
                        hintText: 'العنوان التفصيلي',
                        hintTextDirection: TextDirection.rtl, // اتجاه النص الظاهر
                        suffixIcon: Icon(Icons.location_on, color: Color(0xFF1E3A8A)), // تغيير من suffix إلى prefix
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        alignLabelWithHint: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال العنوان';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // حقل المدينة
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),

                    child: DropdownButtonFormField<String>(
                      value: _cityController.text.isEmpty ? null : _cityController.text,
                      alignment: AlignmentDirectional.centerStart, // محاذاة القائمة المنسدلة لليمين
                      decoration: const InputDecoration(
                        hintText: 'اختر المدينة',
                        hintTextDirection: TextDirection.rtl, // اتجاه النص الظاهر
                        suffixIcon: Icon(Icons.location_city, color: Color(0xFF1E3A8A)), // تغيير من suffix إلى prefix
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        alignLabelWithHint: true,
                       ),
                      items: _cities.map((String city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          alignment: Alignment.centerRight, // محاذاة عناصر القائمة لليمين
                          child: Text(city),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _cityController.text = newValue ?? '';
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء اختيار المدينة';
                        }
                        return null;
                      },
                    ),
                  ),
             
                  const SizedBox(height: 40),
                  
                  // زر إكمال التسجيل
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
    );
  }

  void _completeRegistration() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // محاكاة حفظ البيانات
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // الانتقال إلى الصفحة الرئيسية
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
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