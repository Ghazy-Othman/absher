//
//
//

import 'package:intl/intl.dart';

class EarningsController {
  DateTime selectedDate = DateTime.now();

  final List<Map<String, dynamic>> deliveries = [
    {"vendor": "Burger King", "earning": 47505.0},
    {"vendor": "Pizza Hub", "earning": 31400.0},
    {"vendor": "FreshMart", "earning": 59160.0},
  ];

  double get totalEarnings =>
      deliveries.fold(0.0, (sum, item) => sum + item['earning']);

  int get totalDeliveries => deliveries.length;

  void previousDate() =>
      selectedDate = selectedDate.subtract(Duration(days: 1));

  void nextDate() {
    if (!isToday) selectedDate = selectedDate.add(Duration(days: 1));
  }

  bool get isToday {
    final now = DateTime.now();
    return selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day;
  }

  String get formattedDate => DateFormat.yMMMMd().format(selectedDate);
}
