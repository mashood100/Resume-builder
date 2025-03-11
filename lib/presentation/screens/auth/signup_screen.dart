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

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
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
                    title: 'Create a new account',
                    showLogo: true,
                    logoHeight: 60,
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Signup Form
                  FrostedContainer(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Name Field
                          GenericTextField(
                                onSubmitted: (value){},
                            label: 'Full Name',
                            controller: _nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          
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
                                return 'Please enter a password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          
                          // Confirm Password Field
                          PasswordField(
                            controller: _confirmPasswordController,
                            label: 'Confirm Password',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Error Message
                          Consumer<AppAuthProvider>(
                            builder: (context, authProvider, _) {
                              if (authProvider.errorMessage != null) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
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
                          
                          // Signup Button
                          Consumer<AppAuthProvider>(
                            builder: (context, authProvider, _) {
                              return AuthButton(
                                text: 'CREATE ACCOUNT',
                                isLoading: authProvider.isLoading,
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final success = await authProvider.signUp(
                                      _emailController.text.trim(),
                                      _passwordController.text,
                                      _nameController.text.trim(),
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
                  
                  // Google Sign Up Button
                  Consumer<AppAuthProvider>(
                    builder: (context, authProvider, _) {
                      return SocialAuthButton(
                        text: 'Sign up with Google',
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
                  
                  // Sign In Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          context.go('/login');
                        },
                        child: const Text('Sign In'),
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