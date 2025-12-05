import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/footer.dart';
import '../services/auth_service.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  
  Map<String, dynamic>? _userProfile;
  bool _isLoading = true;
  bool _isEditing = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    final user = _authService.currentUser;
    if (user == null) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final profile = await _authService.getUserProfile(user.uid);
      setState(() {
        _userProfile = profile;
        _displayNameController.text = profile?['displayName'] ?? user.displayName ?? '';
        _phoneController.text = profile?['phone'] ?? '';
        _addressController.text = profile?['address'] ?? '';
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading profile: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      await _authService.updateUserProfile(
        displayName: _displayNameController.text.trim(),
        phone: _phoneController.text.trim(),
        address: _addressController.text.trim(),
      );

      await _loadUserProfile();
      
      setState(() => _isEditing = false);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      setState(() => _isSaving = false);
    }
  }

  Future<void> _signOut() async {
    try {
      await _authService.signOut();
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  Future<void> _deleteAccount() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await _authService.deleteAccount();
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account deleted successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppHeader(
              onLogoTap: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
              onSearchTap: () {},
              onAccountTap: () {},
              onCartTap: () {
                Navigator.pushNamed(context, '/cart');
              },
              onMenuTap: () {},
            ),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'My Account',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: _signOut,
                                  icon: const Icon(Icons.logout),
                                  tooltip: 'Sign out',
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Profile card
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Profile Information',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        if (!_isEditing)
                                          TextButton.icon(
                                            onPressed: () => setState(() => _isEditing = true),
                                            icon: const Icon(Icons.edit),
                                            label: const Text('Edit'),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),

                                    if (_isEditing) ...[
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: _displayNameController,
                                              decoration: const InputDecoration(
                                                labelText: 'Display Name',
                                                border: OutlineInputBorder(),
                                                prefixIcon: Icon(Icons.person_outline),
                                              ),
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Please enter your name';
                                                }
                                                return null;
                                              },
                                            ),
                                            const SizedBox(height: 16),
                                            TextFormField(
                                              controller: _phoneController,
                                              decoration: const InputDecoration(
                                                labelText: 'Phone (optional)',
                                                border: OutlineInputBorder(),
                                                prefixIcon: Icon(Icons.phone_outlined),
                                              ),
                                              keyboardType: TextInputType.phone,
                                            ),
                                            const SizedBox(height: 16),
                                            TextFormField(
                                              controller: _addressController,
                                              decoration: const InputDecoration(
                                                labelText: 'Address (optional)',
                                                border: OutlineInputBorder(),
                                                prefixIcon: Icon(Icons.location_on_outlined),
                                              ),
                                              maxLines: 3,
                                            ),
                                            const SizedBox(height: 16),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    setState(() => _isEditing = false);
                                                    _loadUserProfile();
                                                  },
                                                  child: const Text('Cancel'),
                                                ),
                                                const SizedBox(width: 8),
                                                ElevatedButton(
                                                  onPressed: _isSaving ? null : _saveProfile,
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: const Color(0xFF4d2963),
                                                    foregroundColor: Colors.white,
                                                  ),
                                                  child: _isSaving
                                                      ? const SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child: CircularProgressIndicator(
                                                            strokeWidth: 2,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      : const Text('Save'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ] else ...[
                                      _buildInfoRow('Email', user?.email ?? 'N/A'),
                                      _buildInfoRow('Display Name', _userProfile?['displayName'] ?? user?.displayName ?? 'N/A'),
                                      _buildInfoRow('Phone', _userProfile?['phone'] ?? 'Not set'),
                                      _buildInfoRow('Address', _userProfile?['address'] ?? 'Not set'),
                                      _buildInfoRow('Sign-in Provider', _userProfile?['provider'] ?? 'Unknown'),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Order history card (placeholder)
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Order History',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'No orders yet',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Danger zone
                            Card(
                              color: Colors.red.shade50,
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Danger Zone',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    OutlinedButton.icon(
                                      onPressed: _deleteAccount,
                                      icon: const Icon(Icons.delete_forever),
                                      label: const Text('Delete Account'),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.red,
                                        side: const BorderSide(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
