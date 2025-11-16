class Reminder {
  final int id;
  final String title;
  final String description;
  final DateTime dateTime;
  final String frequency;
  final String status;
  final List<String> selectedDays;

  Reminder({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.frequency,
    required this.status,
    required this.selectedDays,
  });
}
