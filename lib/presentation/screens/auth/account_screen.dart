import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/share-widgets/frosted_container.dart';
import '../../../core/share-widgets/text_field/generic_text_field.dart';
import '../../providers/auth_provider.dart';
import 'widgets/auth_header.dart';
import 'widgets/auth_button.dart';
import 'widgets/password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _profileFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();

  bool _isEditingProfile = false;
  bool _isChangingPassword = false;
  bool _profileUpdateSuccess = false;
  bool _passwordUpdateSuccess = false;

  @override
  void initState() {
    super.initState();
    // Initialize name with current user's display name
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AppAuthProvider>(context, listen: false);
      final user = authProvider.isAuthenticated
          ? FirebaseAuth.instance.currentUser
          : null;
      if (user?.displayName != null) {
        _nameController.text = user!.displayName!;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AppAuthProvider>(context);
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign Out',
            onPressed: () async {
              await authProvider.signOut();
              if (mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Section
            const AuthHeader(
              icon: Icons.account_circle,
              title: 'Profile Information',
              showLogo: false,
            ),
            const SizedBox(height: 24),

            FrostedContainer(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _profileFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User Info
                      if (!_isEditingProfile) ...[
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Name'),
                          subtitle: Text(user?.displayName ?? 'Not set'),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.email),
                          title: const Text('Email'),
                          subtitle: Text(user?.email ?? 'Not available'),
                        ),

                        // Success message
                        if (_profileUpdateSuccess)
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(
                              'Profile updated successfully!',
                              style: TextStyle(
                                color: Colors.green[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                        const SizedBox(height: 16),

                        // Edit Profile Button
                        AuthButton(
                          text: 'EDIT PROFILE',
                          onPressed: () {
                            setState(() {
                              _isEditingProfile = true;
                              _profileUpdateSuccess = false;
                            });
                          },
                        ),
                      ],

                      // Edit Profile Form
                      if (_isEditingProfile) ...[
                        GenericTextField(
                          onSubmitted: (value) {},
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

                        // Error Message
                        if (authProvider.errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text(
                              authProvider.errorMessage!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ),

                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: authProvider.isLoading
                                    ? null
                                    : () {
                                        setState(() {
                                          _isEditingProfile = false;
                                          if (user?.displayName != null) {
                                            _nameController.text =
                                                user!.displayName!;
                                          }
                                        });
                                      },
                                style: OutlinedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: const Text('CANCEL'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: AuthButton(
                                text: 'SAVE',
                                isLoading: authProvider.isLoading,
                                onPressed: () async {
                                  if (_profileFormKey.currentState!
                                      .validate()) {
                                    final success =
                                        await authProvider.updateProfile(
                                      displayName: _nameController.text.trim(),
                                    );

                                    if (success && mounted) {
                                      setState(() {
                                        _isEditingProfile = false;
                                        _profileUpdateSuccess = true;
                                      });
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Password Section
            const AuthHeader(
              icon: Icons.lock_outline,
              title: 'Password',
              showLogo: false,
            ),
            const SizedBox(height: 24),

            FrostedContainer(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _passwordFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!_isChangingPassword) ...[
                        ListTile(
                          leading: const Icon(Icons.lock),
                          title: const Text('Password'),
                          subtitle: const Text('••••••••'),
                        ),

                        // Success message
                        if (_passwordUpdateSuccess)
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(
                              'Password changed successfully!',
                              style: TextStyle(
                                color: Colors.green[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                        const SizedBox(height: 16),

                        // Change Password Button
                        AuthButton(
                          text: 'CHANGE PASSWORD',
                          onPressed: () {
                            setState(() {
                              _isChangingPassword = true;
                              _passwordUpdateSuccess = false;
                            });
                          },
                        ),
                      ],

                      // Change Password Form
                      if (_isChangingPassword) ...[
                        PasswordField(
                          controller: _currentPasswordController,
                          label: 'Current Password',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your current password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        PasswordField(
                          controller: _newPasswordController,
                          label: 'New Password',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a new password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        PasswordField(
                          controller: _confirmPasswordController,
                          label: 'Confirm New Password',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your new password';
                            }
                            if (value != _newPasswordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // Error Message
                        if (authProvider.errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text(
                              authProvider.errorMessage!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ),

                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: authProvider.isLoading
                                    ? null
                                    : () {
                                        setState(() {
                                          _isChangingPassword = false;
                                          _currentPasswordController.clear();
                                          _newPasswordController.clear();
                                          _confirmPasswordController.clear();
                                        });
                                      },
                                style: OutlinedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: const Text('CANCEL'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: AuthButton(
                                text: 'UPDATE',
                                isLoading: authProvider.isLoading,
                                onPressed: () async {
                                  if (_passwordFormKey.currentState!
                                      .validate()) {
                                    final success =
                                        await authProvider.changePassword(
                                      _currentPasswordController.text,
                                      _newPasswordController.text,
                                    );

                                    if (success && mounted) {
                                      setState(() {
                                        _isChangingPassword = false;
                                        _passwordUpdateSuccess = true;
                                        _currentPasswordController.clear();
                                        _newPasswordController.clear();
                                        _confirmPasswordController.clear();
                                      });
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
