import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/models/trip_model.dart';


class PlanTripPage extends StatefulWidget {
  const PlanTripPage({super.key});

  @override
  State<PlanTripPage> createState() => _PlanTripPageState();
}

class _PlanTripPageState extends State<PlanTripPage> {
  String? _fromCity;
  String? _toCity;
  DateTime? _selectedDate;

  final TextEditingController _flightNumberController =
      TextEditingController(text: "AF1234");

  double _luggageSpace = 12;

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
  ];

  @override
  void dispose() {
    _flightNumberController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return "${months[date.month - 1]} ${date.day}, ${date.year}";
  }

  String _extractCode(String text) {
    final match = RegExp(r'\((.*?)\)').firstMatch(text);
    if (match != null) return match.group(1) ?? '';
    return text.length >= 3
        ? text.substring(0, 3).toUpperCase()
        : text.toUpperCase();
  }

  String _extractCity(String text) {
    if (text.contains('(')) {
      return text.split('(').first.trim();
    }
    return text.trim();
  }

  void _showCityPicker(bool isFrom) {
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
              height: MediaQuery.of(context).size.height * 0.75,
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
                      isFrom
                          ? "Select departure city"
                          : "Select destination city",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
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
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final city = filtered[index];
                        final isSelected = isFrom
                            ? _fromCity == "${city['name']} (${city['code']})"
                            : _toCity == "${city['name']} (${city['code']})";

                        return ListTile(
                          leading: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAF3E0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                city["code"]!,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFB8860B),
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            city["name"]!,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            city["country"]!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black45,
                            ),
                          ),
                          trailing: isSelected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Color(0xFFB8860B),
                                )
                              : null,
                          onTap: () {
                            setState(() {
                              if (isFrom) {
                                _fromCity =
                                    "${city['name']} (${city['code']})";
                              } else {
                                _toCity =
                                    "${city['name']} (${city['code']})";
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

  Future<void> _showDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFC39A06),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _swapCities() {
    setState(() {
      final temp = _fromCity;
      _fromCity = _toCity;
      _toCity = temp;
    });
  }

  void _submitTrip() {
    if (_fromCity == null ||
        _toCity == null ||
        _selectedDate == null ||
        _flightNumberController.text.trim().isEmpty) {
      return;
    }

    final trip = TripModel(
      fromCode: _extractCode(_fromCity!),
      fromCity: _extractCity(_fromCity!),
      toCode: _extractCode(_toCity!),
      toCity: _extractCity(_toCity!),
      departureDate: _formatDate(_selectedDate!),
      flightNumber: _flightNumberController.text.trim(),
      luggageSpace: _luggageSpace.toStringAsFixed(0),
      pricePerKg: '8',
    );

    Navigator.pop(context, trip);
  }

  @override
  Widget build(BuildContext context) {
    final isFormValid = _fromCity != null &&
        _toCity != null &&
        _selectedDate != null &&
        _flightNumberController.text.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Plan a Trip",
                style: GoogleFonts.syne(
                  color: const Color(0xFFC39A06),
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Set your route and luggage space before you fly",
                style: GoogleFonts.manrope(
                  color: Colors.black38,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Divider(color: Colors.black12, thickness: 1),
              const SizedBox(height: 20),

              _sectionLabel("FROM"),
              const SizedBox(height: 8),
              _selectableTile(
                icon: Icons.place_outlined,
                text: _fromCity ?? "Select departure city",
                placeholder: _fromCity == null,
                onTap: () => _showCityPicker(true),
              ),

              const SizedBox(height: 14),

              Center(
                child: GestureDetector(
                  onTap: _swapCities,
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDEDEC),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.swap_vert,
                      color: Colors.black54,
                      size: 22,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              _sectionLabel("TO"),
              const SizedBox(height: 8),
              _selectableTile(
                icon: Icons.outlined_flag,
                text: _toCity ?? "Select destination city",
                placeholder: _toCity == null,
                onTap: () => _showCityPicker(false),
              ),

              const SizedBox(height: 20),
              Divider(color: Colors.black12, thickness: 1),
              const SizedBox(height: 20),

              _sectionLabel("DEPARTURE DATE"),
              const SizedBox(height: 8),
              _selectableTile(
                icon: Icons.calendar_today_outlined,
                text: _selectedDate != null
                    ? _formatDate(_selectedDate!)
                    : "Select date",
                placeholder: _selectedDate == null,
                onTap: _showDatePicker,
              ),

              const SizedBox(height: 20),

              _sectionLabel("FLIGHT NUMBER"),
              const SizedBox(height: 8),
              _flightNumberInput(),

              const SizedBox(height: 20),
              Divider(color: Colors.black12, thickness: 1),
              const SizedBox(height: 20),

              _sectionLabel("AVAILABLE LUGGAGE SPACE"),
              const SizedBox(height: 10),
              _luggageBox(),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isFormValid ? _submitTrip : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: const Color(0xFFC39A06),
                    disabledBackgroundColor:
                        // ignore: deprecated_member_use
                        const Color(0xFFC39A06).withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    "Find parcels on this route",
                    style: GoogleFonts.syne(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
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

  Widget _selectableTile({
    required IconData icon,
    required String text,
    required bool placeholder,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFEDEDEC),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),
            Icon(icon, color: const Color(0xFF8E8E8E), size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.manrope(
                  color: placeholder ? Colors.black38 : Colors.black87,
                  fontSize: 15,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 14),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black38,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _flightNumberInput() {
    return Container(
      height: 64,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFEDEDEC),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          const Icon(Icons.flight, color: Color(0xFF8E8E8E), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _flightNumberController,
              onChanged: (_) => setState(() {}),
              style: GoogleFonts.manrope(
                color: Colors.black87,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter flight number",
                hintStyle: GoogleFonts.manrope(
                  color: Colors.black38,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _luggageBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEDEDEC),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Select luggage space",
                style: GoogleFonts.manrope(
                  color: Colors.black38,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFC39A06),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "${_luggageSpace.toStringAsFixed(0)} kg",
                  style: GoogleFonts.syne(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFFC39A06),
              inactiveTrackColor: Colors.grey.shade300,
              thumbColor: const Color(0xFFC39A06),
              // ignore: deprecated_member_use
              overlayColor: const Color(0xFFC39A06).withOpacity(0.18),
              trackHeight: 4,
              thumbShape:
                  const RoundSliderThumbShape(enabledThumbRadius: 10),
            ),
            child: Slider(
              value: _luggageSpace,
              min: 1,
              max: 30,
              divisions: 29,
              onChanged: (value) {
                setState(() {
                  _luggageSpace = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}