import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/screens/list_search.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();

  bool get isFormValid =>
      _fromController.text.isNotEmpty &&
      _toController.text.isNotEmpty &&
      _deadlineController.text.isNotEmpty;

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

  String _cleanCityName(String value) {
    if (value.isEmpty) return '';
    return value.split('(').first.trim();
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
                  Text(
                    isFrom ? "Select departure city" : "Select destination city",
                    style: GoogleFonts.syne(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
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
                      style: GoogleFonts.manrope(
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        hintText: "Search city or country...",
                        hintStyle: GoogleFonts.manrope(
                          color: Colors.black38,
                          fontSize: 15,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black38,
                        ),
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
                        final cityText = "${city['name']} (${city['code']})";

                        final isSelected = isFrom
                            ? _fromController.text == cityText
                            : _toController.text == cityText;

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
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            city["country"]!,
                            style: GoogleFonts.manrope(
                              fontSize: 13,
                              color: Colors.black45,
                            ),
                          ),
                          trailing: isSelected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Color(0xFFB8960A),
                                )
                              : null,
                          onTap: () {
                            setState(() {
                              if (isFrom) {
                                _fromController.text = cityText;
                              } else {
                                _toController.text = cityText;
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

  Widget buildDepart() {
    return GestureDetector(
      onTap: () => _showCityPicker(true),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F0),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              const Icon(
                Icons.keyboard_double_arrow_left,
                color: Color(0xFFB8960A),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _fromController.text.isEmpty ? 'From' : _fromController.text,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.manrope(
                    color: _fromController.text.isEmpty
                        ? Colors.black38
                        : Colors.black87,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTo() {
    return GestureDetector(
      onTap: () => _showCityPicker(false),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F0),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              const Icon(
                Icons.keyboard_double_arrow_right,
                color: Color(0xFFB8960A),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _toController.text.isEmpty ? 'To' : _toController.text,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.manrope(
                    color: _toController.text.isEmpty
                        ? Colors.black38
                        : Colors.black87,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDatePicker() {
    return GestureDetector(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now().add(const Duration(days: 1)),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
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
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F0),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              const Icon(Icons.edit_calendar, color: Color(0xFFB8960A)),
              const SizedBox(width: 8),
              Text(
                _deadlineController.text.isEmpty
                    ? 'Select Date'
                    : _deadlineController.text,
                style: GoogleFonts.manrope(
                  color: _deadlineController.text.isEmpty
                      ? Colors.black38
                      : Colors.black87,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isFormValid
            ? () {
                final fromCity = _cleanCityName(_fromController.text);
                final toCity = _cleanCityName(_toController.text);

                final parcel = ParcelRequest(
                  fromCity: fromCity,
                  toCity: toCity,
                  description: 'Parcel delivery request',
                  packageType: 'General',
                  weight: 1.0,
                  price: '',
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ListSearch(
                      parcel: parcel,
                      fromCity: fromCity,
                      toCity: toCity,
                    ),
                  ),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF2F2F0),
          disabledBackgroundColor: const Color(0xFFF2F2F0),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: BorderSide(
            color: isFormValid ? const Color(0xFFB8960A) : Colors.black26,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Search',
          style: GoogleFonts.syne(
            color: isFormValid ? const Color(0xFFB8960A) : Colors.black38,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F0),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(color: Color(0xFFEDEDEC)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Find a Traveler',
                style: GoogleFonts.syne(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                ),
              ),
              Text(
                'Who can carry your parcel',
                style: GoogleFonts.syne(
                  color: Colors.black38,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),
              buildDepart(),
              const SizedBox(height: 16),
              buildTo(),
              const SizedBox(height: 16),
              buildDatePicker(),
              buildSearchButton(),
            ],
          ),
        ),
      ),
    );
  }
}