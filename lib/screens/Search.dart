import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p2p_delivery_app/screens/ListSearch.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _birthDateController = TextEditingController();

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Container(
                  height: 648,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFEDEDEC),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
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
                        'Who can carry you parcel',
                        style: GoogleFonts.syne(
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 290,
                        width: 380,
                        decoration: BoxDecoration(
                          color: Color(0xFFEDEDEC),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: const Color.fromARGB(255, 232, 228, 228)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 3,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'From',
                                        style: GoogleFonts.syne(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 253),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 3,
                                                offset: Offset(0, 2))
                                          ],
                                        ),
                                        height: 45,
                                        child: TextField(
                                          keyboardType: TextInputType.name,
                                          style: GoogleFonts.manrope(
                                            color: Colors.black87,
                                            fontSize: 16,
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                                bottom: 4, left: 10),
                                            hintText: 'Depart',
                                            hintStyle: GoogleFonts.manrope(
                                              color: Colors.black38,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'To',
                                        style: GoogleFonts.syne(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 253),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 3,
                                                offset: Offset(0, 2))
                                          ],
                                        ),
                                        height: 45,
                                        child: TextField(
                                          keyboardType: TextInputType.name,
                                          style: GoogleFonts.manrope(
                                            color: Colors.black87,
                                            fontSize: 16,
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                                bottom: 4, left: 10),
                                            hintText: 'Destination',
                                            hintStyle: GoogleFonts.manrope(
                                              color: Colors.black38,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Date',
                                    style: GoogleFonts.syne(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255, 253),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 3,
                                            offset: Offset(0, 2))
                                      ],
                                    ),
                                    height: 45,
                                    child: TextField(
                                      controller: _birthDateController,
                                      readOnly: true,
                                      onTap: () async {
                                        DateTime? picked = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime(2000),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now(),
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
                                            _birthDateController.text =
                                                "${picked.day.toString().padLeft(2, '0')}/"
                                                "${picked.month.toString().padLeft(2, '0')}/"
                                                "${picked.year}";
                                          });
                                        }
                                      },
                                      keyboardType: TextInputType.datetime,
                                      style: GoogleFonts.manrope(
                                        color: Colors.black87,
                                        fontSize: 16,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            bottom: 4, left: 10),
                                        hintText: 'Delivery Date',
                                        hintStyle: GoogleFonts.manrope(
                                          color: Colors.black38,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 19),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ListSearch()),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFB8960A),
                                      padding: EdgeInsets.all(14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      'Search Travelers',
                                      style: GoogleFonts.manrope(
                                        color: Colors.black38,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}