// ignore_for_file: use_build_context_synchronously, unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:my_app/screens/match_system.dart';
import 'package:my_app/screens/auth_service.dart';

class Posting extends StatefulWidget {
  const Posting({super.key});

  @override
  State<Posting> createState() => _PostingState();
}

final List<Map<String, String>> _cities = [
  {"name": "Algiers", "code": "ALG", "country": "Algeria"},
  {"name": "Oran", "code": "ORN", "country": "Algeria"},
  {"name": "Constantine", "code": "CZL", "country": "Algeria"},
  {"name": "Paris", "code": "CDG", "country": "France"},
  {"name": "Lyon", "code": "LYS", "country": "France"},
  {"name": "Marseille", "code": "MRS", "country": "France"},
  {"name": "London", "code": "LHR", "country": "UK"},
  {"name": "Manchester", "code": "MAN", "country": "UK"},
  {"name": "Dubai", "code": "DXB", "country": "UAE"},
  {"name": "Istanbul", "code": "IST", "country": "Turkey"},
  {"name": "Madrid", "code": "MAD", "country": "Spain"},
  {"name": "Barcelona", "code": "BCN", "country": "Spain"},
  {"name": "Rome", "code": "FCO", "country": "Italy"},
  {"name": "Milan", "code": "MXP", "country": "Italy"},
  {"name": "Frankfurt", "code": "FRA", "country": "Germany"},
  {"name": "Amsterdam", "code": "AMS", "country": "Netherlands"},
  {"name": "Brussels", "code": "BRU", "country": "Belgium"},
  {"name": "Montreal", "code": "YUL", "country": "Canada"},
  {"name": "New York", "code": "JFK", "country": "USA"},
  {"name": "Tunis", "code": "TUN", "country": "Tunisia"},
  {"name": "Casablanca", "code": "CMN", "country": "Morocco"},
  {"name": "Cairo", "code": "CAI", "country": "Egypt"},
  {"name": "Riyadh", "code": "RUH", "country": "Saudi Arabia"},
  {"name": "Doha", "code": "DOH", "country": "Qatar"},
  {"name": "Toronto", "code": "YYZ", "country": "Canada"},
  {"name": "Beijing", "code": "PEK", "country": "China"},
  {"name": "Tokyo", "code": "NRT", "country": "Japan"},
];

class _PostingState extends State<Posting> {
  double _weight = 1.5;
  String _selectedType = '';
  final String _selectedDeliveryType = '';

  bool isRememberMe = false;
  bool _isSubmitting = false;

  int? _activePhotoIndex;

  final ImagePicker _picker = ImagePicker();

  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _receiverNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final List<String> _uploadedPhotos = ['', '', ''];

  void _showCityPicker(bool isPickup) {
    String query = "";
    List<Map<String, String>> filtered = List.from(_cities);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.80,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      isPickup
                          ? "Select pickup city"
                          : "Select destination city",
                      style: GoogleFonts.syne(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: TextField(
                      autofocus: true,
                      onChanged: (value) {
                        setModalState(() {
                          query = value.toLowerCase();
                          filtered = _cities.where((c) {
                            return c["name"]!.toLowerCase().contains(query) ||
                                c["country"]!.toLowerCase().contains(query) ||
                                c["code"]!.toLowerCase().contains(query);
                          }).toList();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Search city or country...",
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.black38),
                        filled: true,
                        fillColor: const Color(0xFFF2F2F2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final city = filtered[index];
                        final text = "${city['name']} (${city['code']})";

                        return ListTile(
                          leading: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAF3E0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                city["code"]!,
                                style: GoogleFonts.syne(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFB8960A),
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            city["name"]!,
                            style: GoogleFonts.syne(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            city["country"]!,
                            style: GoogleFonts.manrope(
                              fontSize: 13,
                              color: Colors.black45,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (isPickup) {
                                _pickupController.text = text;
                              } else {
                                _destinationController.text = text;
                              }
                            });
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _pickPhoto(ImageSource source) async {
    if (_activePhotoIndex == null) return;

    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        _uploadedPhotos[_activePhotoIndex!] = image.path;
        _activePhotoIndex = null;
      });
    }
  }

  Widget _photoOptionInline({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFF5EFCF),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: const Color(0xFFB8960A),
                size: 25,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.syne(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.syne(
        color: Colors.black54,
        fontSize: 13,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _inputBox({
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    TextEditingController? controller,
    bool readOnly = false,
    VoidCallback? onTap,
    Widget? suffixIcon,
  }) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xFFEDEDEC),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 2))
        ],
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: keyboardType,
        style: GoogleFonts.manrope(color: Colors.black87, fontSize: 15),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          hintText: hint,
          hintStyle: GoogleFonts.manrope(color: Colors.black38, fontSize: 15),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  Widget _dropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      hint: Text(
        hint,
        style: GoogleFonts.manrope(color: Colors.black38, fontSize: 15),
      ),
      icon: const Icon(Icons.keyboard_arrow_down_rounded,
          color: Colors.black38),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: Color(0xFFB8960A), width: 1.5),
        ),
        filled: true,
        fillColor: const Color(0xFFEDEDEC),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      ),
      items: items
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.manrope(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black87,
            size: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Post a Listing',
                style: GoogleFonts.syne(
                  color: const Color(0xFFB8960A),
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Ship With a Traveler, Anywhere & Anytime',
                style: GoogleFonts.manrope(
                  color: Colors.black38,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.black12, thickness: 1),
              const SizedBox(height: 20),

              _sectionLabel('PICKUP LOCATION'),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _showCityPicker(true),
                child: AbsorbPointer(
                  child: _inputBox(
                    hint: 'Enter pickup location',
                    controller: _pickupController,
                    readOnly: true,
                    suffixIcon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.black38,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              _sectionLabel('DESTINATION'),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _showCityPicker(false),
                child: AbsorbPointer(
                  child: _inputBox(
                    hint: 'Enter destination',
                    controller: _destinationController,
                    readOnly: true,
                    suffixIcon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.black38,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              const Divider(color: Colors.black12, thickness: 1),
              const SizedBox(height: 20),

              _sectionLabel('PACKAGE TYPE'),
              const SizedBox(height: 8),
              _dropdown(
                hint: 'Select package type',
                value: _selectedType.isEmpty ? null : _selectedType,
                items: const [
                  'Documents',
                  'Electronics',
                  'Clothes',
                  'Gift',
                  'Fragile',
                  'Other'
                ],
                onChanged: (val) => setState(() => _selectedType = val!),
              ),

              const SizedBox(height: 20),
              _sectionLabel('PACKAGE WEIGHT'),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEDEC),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 3,
                        offset: Offset(0, 2))
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select weight',
                          style: GoogleFonts.manrope(
                            color: Colors.black38,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFB8960A),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${_weight.toStringAsFixed(1)} kg',
                            style: GoogleFonts.syne(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: _weight,
                      min: 0.5,
                      max: 30.0,
                      divisions: 59,
                      activeColor: const Color(0xFFB8960A),
                      onChanged: (value) => setState(() => _weight = value),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              _sectionLabel('PACKAGE DESCRIPTION'),
              const SizedBox(height: 8),

              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEDEC),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 3,
                        offset: Offset(0, 2))
                  ],
                ),
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 14),
                    hintText: 'Add a description (optional).',
                    hintStyle: GoogleFonts.manrope(
                      color: Colors.black38,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              const Divider(color: Colors.black12, thickness: 1),
              const SizedBox(height: 20),

              _sectionLabel('UPLOAD PHOTOS'),
              const SizedBox(height: 6),
              Text(
                'Add up to 3 photos of your package',
                style: GoogleFonts.manrope(
                  color: Colors.black38,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 12),

              Row(
                children: List.generate(3, (index) {
                  final hasImage = _uploadedPhotos[index].isNotEmpty;

                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: index < 2 ? 10 : 0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _activePhotoIndex =
                                _activePhotoIndex == index ? null : index;
                          });
                        },
                        child: Container(
                          height: 90,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDEDEC),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  // ignore: deprecated_member_use
                                  const Color(0xFFB8960A).withOpacity(0.4),
                              width: 1.5,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                          child: hasImage
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(11),
                                  child: Image.file(
                                    File(_uploadedPhotos[index]),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Color(0xFFB8960A),
                                      size: 26,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Photo ${index + 1}',
                                      style: GoogleFonts.manrope(
                                        color: Colors.black38,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  );
                }),
              ),

              if (_activePhotoIndex != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Add Photo ${_activePhotoIndex! + 1}',
                          style: GoogleFonts.syne(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 18),
                        _photoOptionInline(
                          icon: Icons.camera_alt_outlined,
                          title: 'Take Photo',
                          onTap: () => _pickPhoto(ImageSource.camera),
                        ),
                        const SizedBox(height: 10),
                        _photoOptionInline(
                          icon: Icons.photo_library_outlined,
                          title: 'Choose from Gallery',
                          onTap: () => _pickPhoto(ImageSource.gallery),
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 20),
              const Divider(color: Colors.black12, thickness: 1),
              const SizedBox(height: 10),

              Row(
                children: [
                  Checkbox(
                    value: isRememberMe,
                    checkColor: Colors.white,
                    activeColor: Colors.black38,
                    onChanged: (value) {
                      setState(() => isRememberMe = value!);
                    },
                  ),
                  Expanded(
                    child: Text(
                      'I confirm that this package does not contain any prohibited or illegal items',
                      style: GoogleFonts.manrope(
                        color: Colors.black38,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting
                      ? null
                      : () async {
                          if (!isRememberMe) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please confirm the package contents',
                                ),
                              ),
                            );
                            return;
                          }

                          setState(() => _isSubmitting = true);

                          final result = await AuthService().saveParcel(
                            pickupLocation: _pickupController.text.trim(),
                            destination: _destinationController.text.trim(),
                            packageType: _selectedType,
                            weight: '${_weight.toStringAsFixed(1)} kg',
                            description: _descriptionController.text.trim(),
                            deadline: _deadlineController.text,
                            deliveryType: _selectedDeliveryType,
                            receiverName: _receiverNameController.text.trim(),
                            price: _priceController.text.trim(),
                          );

                          setState(() => _isSubmitting = false);

                          if (result == 'success') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MatchSystem(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $result')),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: const Color(0xFFB8960A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    _isSubmitting ? 'Posting...' : 'Post Listing',
                    style: GoogleFonts.syne(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}