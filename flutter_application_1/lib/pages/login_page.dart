import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/app_constants.dart';
import 'package:flutter_application_1/navigation/main_scaffold.dart';
import 'package:flutter_application_1/pages/register_page.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/widgets/loading_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _obscureText = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        bool success = await _authService.login(
          _emailController.text.trim(),
          _passwordController.text,
        );

        if (success && mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainScaffold()),
          );
        } else if (!success && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(AppConstants.loginFailedError),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
           ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${AppConstants.loginFailedError} Detay: ${e.toString()}'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
         print("Login Hatası: $e");
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
      appBar: AppBar(title: const Text(AppConstants.loginPageTitle)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
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
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: AppConstants.passwordLabel,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.passwordEmptyError;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppConstants.paddingLarge),
                LoadingButton(
                  isLoading: _isLoading,
                  onPressed: _login,
                  child: const Text(AppConstants.loginButtonText),
                ),
                const SizedBox(height: AppConstants.paddingMedium),
                TextButton(
                  onPressed: _isLoading ? null : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterPage()),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(AppConstants.noAccountText),
                      SizedBox(width: AppConstants.paddingSmall),
                      Text(
                        AppConstants.registerButtonText,
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