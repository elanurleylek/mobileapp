import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/app_constants.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/widgets/loading_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authService = AuthService();
  
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  bool _isLoading = false;
  
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    
    // Başlangıçta animasyonu çalıştır
    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    // Klavyeyi kapat
    FocusScope.of(context).unfocus();
    
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        bool success = await _authService.register(
          _emailController.text.trim(),
          _passwordController.text,
        );

        if (success && mounted) {
          // Başarılı kayıt mesajı göster
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(AppConstants.registerSuccessMessage),
              backgroundColor: Colors.green,
            ),
          );
          
          // Ana ekrana dön
          Navigator.pop(context);
        } else if (!success && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(AppConstants.registerFailedError),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${AppConstants.registerFailedError} Detay: ${e.toString()}'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
        print("Kayıt Hatası: $e");
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.registerPageTitle),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: AppConstants.emailLabel,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.emailEmptyError;
                    }
                    if (!value.contains('@')) {
                      return AppConstants.emailInvalidError;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppConstants.paddingMedium),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscureTextPassword,
                  decoration: InputDecoration(
                    labelText: AppConstants.passwordLabel,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureTextPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureTextPassword = !_obscureTextPassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.passwordEmptyError;
                    }
                    if (value.length < 6) {
                      return AppConstants.passwordLengthError;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppConstants.paddingMedium),
                FadeTransition(
                  opacity: _animation,
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureTextConfirmPassword,
                    decoration: InputDecoration(
                      labelText: AppConstants.confirmPasswordLabel,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureTextConfirmPassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppConstants.confirmPasswordEmptyError;
                      }
                      if (value != _passwordController.text) {
                        return AppConstants.passwordsDoNotMatchError;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: AppConstants.paddingLarge),
                LoadingButton(
                  isLoading: _isLoading,
                  onPressed: _register,
                  child: const Text(AppConstants.registerButtonText),
                ),
                const SizedBox(height: AppConstants.paddingMedium),
                TextButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          Navigator.pop(context);
                        },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(AppConstants.alreadyHaveAccountText),
                      SizedBox(width: AppConstants.paddingSmall),
                      Text(
                        AppConstants.loginButtonText,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}