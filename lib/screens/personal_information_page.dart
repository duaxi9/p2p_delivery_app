import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/screens/auth_service.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({super.key});

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  final ImagePicker _picker = ImagePicker();

  bool _isEditing = false;
  bool _showSensitiveData = false;

  File? _profileImage;

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _cityController;
  late final TextEditingController _hometownController;
  late final TextEditingController _birthdayController;
  late final TextEditingController _memberSinceController;

  @override
void initState() {
  super.initState();

  _nameController = TextEditingController();
  _emailController = TextEditingController();
  _phoneController = TextEditingController();
  _cityController = TextEditingController();
  _hometownController = TextEditingController();
  _birthdayController = TextEditingController();
  _memberSinceController = TextEditingController();

  _loadUserData();
}

Future<void> _loadUserData() async {
  final data = await AuthService().getUserData();

  if (data == null || !mounted) return;

  final firstName = (data['firstname'] ?? '').toString();
  final lastName = (data['lastname'] ?? '').toString();

  setState(() {
    _nameController.text = '$firstName $lastName'.trim();
    _emailController.text = (data['email'] ?? '').toString();
    _phoneController.text = (data['phonenumber'] ?? '').toString();
    _birthdayController.text = (data['date'] ?? '').toString();

    _cityController.text = (data['city'] ?? '—').toString();
    _hometownController.text = (data['hometown'] ?? '—').toString();

    final createdAt = data['createdAt'];
    if (createdAt != null) {
      try {
        final date = createdAt.toDate();
        _memberSinceController.text =
            '${date.day}/${date.month}/${date.year}';
      } catch (_) {
        _memberSinceController.text = '—';
      }
    } else {
      _memberSinceController.text = '—';
    }
  });
}

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _hometownController.dispose();
    _birthdayController.dispose();
    _memberSinceController.dispose();
    super.dispose();
  }

  Future<void> _pickProfileImage(ImageSource source) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );

      if (file == null) return;

      setState(() {
        _profileImage = File(file.path);
      });
    } catch (e) {
      _showSnackBar('Could not pick image');
    }
  }

  void _showPhotoPickerSheet() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Change Profile Photo',
                  style: GoogleFonts.syne(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 18),
                _sheetOption(
                  icon: Icons.photo_camera_outlined,
                  title: 'Take Photo',
                  onTap: () {
                    Navigator.pop(context);
                    _pickProfileImage(ImageSource.camera);
                  },
                ),
                const SizedBox(height: 10),
                _sheetOption(
                  icon: Icons.photo_library_outlined,
                  title: 'Choose from Gallery',
                  onTap: () {
                    Navigator.pop(context);
                    _pickProfileImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    setState(() {
      _isEditing = false;
    });
    _showSnackBar('Changes saved');
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  String _maskedEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2 || parts[0].isEmpty) return email;

    final name = parts[0];
    final domain = parts[1];

    return '${name[0]}********@$domain';
  }

  String _maskedPhone(String phone) {
    if (phone.length < 4) return phone;
    return '${phone.substring(0, 2)}******${phone.substring(phone.length - 2)}';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : Colors.black,
        ),
        title: Text(
          'Personal Information',
          style: GoogleFonts.syne(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _isEditing ? _saveChanges : _toggleEdit,
            icon: Icon(
              _isEditing ? Icons.check_rounded : Icons.edit_outlined,
              color: const Color(0xFFB8960A),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
        child: Column(
          children: [
            _topCard(isDark),
            const SizedBox(height: 18),
            _informationCard(isDark),
          ],
        ),
      ),
    );
  }

  Widget _topCard(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  color: const Color(0xFFB8960A),
                  borderRadius: BorderRadius.circular(28),
                  image: _profileImage != null
                      ? DecorationImage(
                          image: FileImage(_profileImage!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _profileImage == null
                    ? Center(
                        child: Text(
                          _nameController.text.isNotEmpty
                        ? _nameController.text
                          .trim()
                          .split(' ')
                          .where((e) => e.isNotEmpty)
                          .map((e) => e[0])
                          .take(2)
                          .join()
                          .toUpperCase()
                          : '?',
                          style: GoogleFonts.syne(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      )
                    : null,
              ),
              Positioned(
                right: -2,
                bottom: -2,
                child: GestureDetector(
                  onTap: _showPhotoPickerSheet,
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB8960A),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            _nameController.text,
            style: GoogleFonts.syne(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _showSensitiveData
                ? _emailController.text
                : _maskedEmail(_emailController.text),
            style: GoogleFonts.manrope(
              color: isDark ? Colors.white54 : Colors.black45,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () {
              setState(() {
                _showSensitiveData = !_showSensitiveData;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _showSensitiveData
                    ? const Color(0xFFE8F5E9)
                    : const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _showSensitiveData
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 16,
                    color: _showSensitiveData
                        ? const Color(0xFF1E8E3E)
                        : Colors.black54,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _showSensitiveData
                        ? 'Sensitive data visible'
                        : 'Sensitive data hidden',
                    style: GoogleFonts.syne(
                      color: _showSensitiveData
                          ? const Color(0xFF1E8E3E)
                          : Colors.black54,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _informationCard(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _editableField(
            isDark: isDark,
            icon: Icons.person_outline,
            title: 'Full Name',
            controller: _nameController,
            displayedValue: _nameController.text,
          ),
          _divider(),
          _editableField(
            isDark: isDark,
            icon: Icons.email_outlined,
            title: 'Email Address',
            controller: _emailController,
            displayedValue: _showSensitiveData
                ? _emailController.text
                : _maskedEmail(_emailController.text),
            keyboardType: TextInputType.emailAddress,
          ),
          _divider(),
          _editableField(
            isDark: isDark,
            icon: Icons.phone_outlined,
            title: 'Phone Number',
            controller: _phoneController,
            displayedValue: _showSensitiveData
                ? _phoneController.text
                : _maskedPhone(_phoneController.text),
            keyboardType: TextInputType.phone,
          ),
          _divider(),
          _editableField(
            isDark: isDark,
            icon: Icons.location_on_outlined,
            title: 'Current City',
            controller: _cityController,
            displayedValue: _cityController.text,
          ),
          _divider(),
          _editableField(
            isDark: isDark,
            icon: Icons.home_outlined,
            title: 'Hometown',
            controller: _hometownController,
            displayedValue: _hometownController.text,
          ),
          _divider(),
          _editableField(
            isDark: isDark,
            icon: Icons.cake_outlined,
            title: 'Birthday',
            controller: _birthdayController,
            displayedValue: _birthdayController.text,
          ),
          _divider(),
          _readOnlyField(
            isDark: isDark,
            icon: Icons.calendar_month_outlined,
            title: 'Member Since',
            value: _memberSinceController.text,
          ),
          const SizedBox(height: 18),
          if (!_isEditing)
            GestureDetector(
              onTap: _toggleEdit,
              child: _mainButton('Edit Information'),
            ),
          if (_isEditing)
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isEditing = false;
                      });
                    },
                    child: _secondaryButton('Cancel', isDark),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: _saveChanges,
                    child: _mainButton('Save'),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 12),
          if (!_isEditing)
            Text(
              'Protect your privacy. Ensure only you can access your sensitive information.',
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                color: isDark ? Colors.white54 : Colors.black45,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }

  Widget _editableField({
    required bool isDark,
    required IconData icon,
    required String title,
    required TextEditingController controller,
    required String displayedValue,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: const Color(0xFFB8960A).withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFB8960A),
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    color: isDark ? Colors.white54 : Colors.black45,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                _isEditing
                    ? TextField(
                        controller: controller,
                        keyboardType: keyboardType,
                        style: GoogleFonts.syne(
                          color: isDark ? Colors.white : Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          filled: true,
                          fillColor: isDark
                              ? const Color(0xFF242424)
                              : const Color(0xFFF6F6F6),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      )
                    : Text(
                        displayedValue,
                        style: GoogleFonts.syne(
                          color: isDark ? Colors.white : Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _readOnlyField({
    required bool isDark,
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: const Color(0xFFB8960A).withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFB8960A),
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    color: isDark ? Colors.white54 : Colors.black45,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: GoogleFonts.syne(
                    color: isDark ? Colors.white : Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'This value is set automatically and cannot be changed.',
                  style: GoogleFonts.manrope(
                    color: isDark ? Colors.white38 : Colors.black38,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.lock_outline,
            size: 16,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _mainButton(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFB8960A),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.syne(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Widget _secondaryButton(String text, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.syne(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Color(0xFFF1F1F1),
    );
  }

  Widget _sheetOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: const Color(0xFFB8960A).withOpacity(0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: const Color(0xFFB8960A),
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.syne(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}