import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/share-widgets/frosted_container.dart';
import '../../../core/share-widgets/text_field/generic_text_field.dart';
import '../../providers/auth_provider.dart';
import 'widgets/auth_header.dart';
import 'widgets/auth_button.dart';
import 'widgets/password_field.dart';
import 'widgets/auth_divider.dart';
import 'widgets/social_auth_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo and Title
                  const AuthHeader(
                    title: 'Resume Builder',
                    subtitle: 'Sign in to your account',
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Login Form
                  FrostedContainer(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Email Field
                          GenericTextField(
                                onSubmitted: (value){},
                            label: 'Email',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          
                          // Password Field
                          PasswordField(
                            controller: _passwordController,
                            label: 'Password',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          
                          // Forgot Password Link
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                context.push('/forgot-password');
                              },
                              child: const Text('Forgot Password?'),
                            ),
                          ),
                          
                          // Error Message
                          Consumer<AppAuthProvider>(
                            builder: (context, authProvider, _) {
                              if (authProvider.errorMessage != null) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    authProvider.errorMessage!,
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.error,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Login Button
                          Consumer<AppAuthProvider>(
                            builder: (context, authProvider, _) {
                              return AuthButton(
                                text: 'SIGN IN',
                                isLoading: authProvider.isLoading,
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final success = await authProvider.login(
                                      _emailController.text.trim(),
                                      _passwordController.text,
                                    );
                                    
                                    if (success && mounted) {
                                      context.go('/');
                                    }
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // OR Divider
                  const AuthDivider(),
                  
                  const SizedBox(height: 24),
                  
                  // Google Sign In Button
                  Consumer<AppAuthProvider>(
                    builder: (context, authProvider, _) {
                      return SocialAuthButton(
                        text: 'Sign in with Google',
                        imagePath: 'assets/images/google_logo.png',
                        isLoading: authProvider.isLoading,
                        onPressed: () async {
                          final success = await authProvider.signInWithGoogle();
                          if (success && mounted) {
                            context.go('/');
                          }
                        },
                      );
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          context.push('/signup');
                        },
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 