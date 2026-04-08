class TripModel {
  final String fromCode;
  final String fromCity;
  final String toCode;
  final String toCity;
  final String departureDate;
  final String flightNumber;
  final String luggageSpace;
  final String pricePerKg;

  const TripModel({
    required this.fromCode,
    required this.fromCity,
    required this.toCode,
    required this.toCity,
    required this.departureDate,
    required this.flightNumber,
    required this.luggageSpace,
    required this.pricePerKg,
  });
}