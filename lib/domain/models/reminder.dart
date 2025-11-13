class Reminder {
  final int id;
  final String title;
  final String description;
  final DateTime dateTime;
  final String frequency;
  final String status;

  Reminder({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.frequency,
    required this.status,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dateTime: DateTime.parse(json['dateTime']),
      frequency: json['frequency'],
      status: json['status'],
    );
  }
}
