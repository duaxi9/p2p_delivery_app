// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: unused_import
import 'package:my_app/screens/home_screen.dart';
import 'package:my_app/screens/match_system.dart';


class Posting extends StatefulWidget {
  const Posting({super.key});

  @override
  State<Posting> createState() => _PostingState();
}

class _PostingState extends State<Posting> {
  double _weight = 1.5;
  String _selectedType = '';
  String _selectedDeliveryType = '';
  bool isRememberMe = false;
  final TextEditingController _deadlineController = TextEditingController();
  final List<String> _uploadedPhotos = ['', '', ''];

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
        color: Color(0xFFEDEDEC),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
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
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
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
      // ignore: deprecated_member_use
      value: value,
      hint: Text(
        hint,
        style: GoogleFonts.manrope(color: Colors.black38, fontSize: 15),
      ),
      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black38),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.black12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.black12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFFB8960A), width: 1.5),
        ),
        filled: true,
        fillColor: Color(0xFFEDEDEC),
        contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      ),
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: GoogleFonts.manrope(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5F5),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Header ──────────────────────────────────
              Text(
                'Post a Listing',
                style: GoogleFonts.syne(
                  color: Color(0xFFB8960A),
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
              Divider(color: Colors.black12, thickness: 1),
              const SizedBox(height: 20),

              // ── Route ───────────────────────────────────
              _sectionLabel('PICKUP LOCATION'),
              const SizedBox(height: 8),
              _inputBox(hint: 'Enter pickup location'),
              const SizedBox(height: 15),
              _sectionLabel('DESTINATION'),
              const SizedBox(height: 8),
              _inputBox(hint: 'Enter destination'),
              const SizedBox(height: 20),

              Divider(color: Colors.black12, thickness: 1),
              const SizedBox(height: 20),

              // ── Package ─────────────────────────────────
              _sectionLabel('PACKAGE TYPE'),
              const SizedBox(height: 8),
              _dropdown(
                hint: 'Select package type',
                value: _selectedType.isEmpty ? null : _selectedType,
                items: ['Documents', 'Electronics', 'Clothes', 'Gift', 'Fragile', 'Other'],
                onChanged: (val) => setState(() => _selectedType = val!),
              ),

              const SizedBox(height: 20),
              _sectionLabel('PACKAGE WEIGHT'),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFEDEDEC),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 2))
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
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(0xFFB8960A),
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
                    const SizedBox(height: 8),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: const Color(0xFFB8960A),
                        inactiveTrackColor: Colors.grey.shade300,
                        thumbColor: const Color(0xFFB8960A),
                        // ignore: deprecated_member_use
                        overlayColor: const Color(0xFFB8960A).withOpacity(0.2),
                        trackHeight: 4,
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                      ),
                      child: Slider(
                        value: _weight,
                        min: 0.5,
                        max: 30.0,
                        divisions: 59,
                        onChanged: (value) => setState(() => _weight = value),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              _sectionLabel('PACKAGE DESCRIPTION'),
              const SizedBox(height: 8),

              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEDEDEC),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 2))
                  ],
                ),
                height: 100,
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                    hintText: 'Add a describe (optional).',
                    hintStyle: GoogleFonts.manrope(color: Colors.black38, fontSize: 14),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Divider(color: Colors.black12, thickness: 1),
              const SizedBox(height: 20),

              // ── Delivery ────────────────────────────────
              _sectionLabel('DELIVERY DEADLINE'),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Color(0xFFB8960A),
                            onPrimary: Colors.white,
                            onSurface: Colors.black87,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    setState(() {
                      _deadlineController.text =
                          "${picked.day.toString().padLeft(2, '0')}/"
                          "${picked.month.toString().padLeft(2, '0')}/"
                          "${picked.year}";
                    });
                  }
                },
                child: AbsorbPointer(
                  child: _inputBox(
                    hint: 'Select date',
                    controller: _deadlineController,
                    readOnly: true,
                    suffixIcon: Icon(Icons.calendar_today, color: Color(0xFFB8960A), size: 18),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              _sectionLabel('DELIVERY DETAILS'),
              const SizedBox(height: 8),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Delivery type',
                            style: GoogleFonts.manrope(
                                color: Colors.black38, fontSize: 14, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        _dropdown(
                          hint: 'Select type',
                          value: _selectedDeliveryType.isEmpty ? null : _selectedDeliveryType,
                          items: ['Hand-to-hand', 'Airport meeting', 'Home delivery'],
                          onChanged: (val) => setState(() => _selectedDeliveryType = val!),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Receiver\'s name',
                            style: GoogleFonts.manrope(
                                color: Colors.black38, fontSize: 14, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        _inputBox(hint: 'Enter full name', keyboardType: TextInputType.name),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),
              Text('Proposed price',
                  style: GoogleFonts.manrope(
                      color: Colors.black38, fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              _inputBox(
                hint: 'Enter price',
                keyboardType: TextInputType.number,
                suffixIcon: Icon(Icons.attach_money, color: Color(0xFFB8960A), size: 18),
              ),

              const SizedBox(height: 20),
              Divider(color: Colors.black12, thickness: 1),
              const SizedBox(height: 20),

              // ── Upload Photos ────────────────────────────
              _sectionLabel('UPLOAD PHOTOS'),
              const SizedBox(height: 6),
              Text(
                'Add up to 3 photos of your package',
                style: GoogleFonts.manrope(color: Colors.black38, fontSize: 13),
              ),
              const SizedBox(height: 12),

              Row(
                children: List.generate(3, (index) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: index < 2 ? 10 : 0),
                      child: GestureDetector(
                        // ignore: avoid_print
                        onTap: () => print('Upload photo ${index + 1}'),
                        child: Container(
                          height: 90,
                          decoration: BoxDecoration(
                            color: Color(0xFFEDEDEC),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              // ignore: deprecated_member_use
                              color: Color(0xFFB8960A).withOpacity(0.4),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 2))
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo_outlined,
                                  color: Color(0xFFB8960A), size: 26),
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

              const SizedBox(height: 20),
              

              Divider(color: Colors.black12, thickness: 1),
              const SizedBox(height: 10),

///////////////////////////////////////






Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: <Widget>[
    Theme(
      data: ThemeData(unselectedWidgetColor: Colors.black),
      child: Checkbox(
        value: isRememberMe,
        checkColor: Colors.white,
        activeColor: Colors.black38,
        onChanged: (value) {
          setState(() {
            isRememberMe = value!;
          });
        },
      ),
    ),
    Expanded(
      child: Text(
        'I confirm that this package does not contain any prohibited or illegal items',
        style: GoogleFonts.manrope(
          color: Colors.black38,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    ),
  ],
),



const SizedBox(height: 10),


        ///////////////////////////

              // ── Submit ───────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => MatchSystem()),
      ),                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16),
                    backgroundColor: Color(0xFFB8960A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    'Post Listing',
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