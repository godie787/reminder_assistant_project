import 'package:flutter/material.dart';
import 'package:reminder_assistant/domain/entities/reminder/reminder.dart';

class ReminderDetailDialog extends StatelessWidget {
  final Reminder reminder;
  final VoidCallback onClose;

  const ReminderDetailDialog({
    super.key,
    required this.reminder,
    required this.onClose,
  });

  String _formatDays(List<String> days) {
    if (days.isEmpty) return "Sin días seleccionados";
    return days.join(", ").toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final bool isWeekly = reminder.frequency.toLowerCase() == "semanal";

    return AlertDialog(
        backgroundColor: Color(0xffD9D9D9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: Color(0xFF0078D7),
          width: 3,
        ),
      ),
      title: Text(
        reminder.title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Color(0xFF0078D7),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            reminder.description.isEmpty
                ? "Sin descripción."
                : reminder.description,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black87,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              const Icon(Icons.repeat, color: Color(0xFFD97015), size: 28),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Frecuencia: ${reminder.frequency.toUpperCase()}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          if (isWeekly) ...[
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.calendar_month,
                    color: Color(0xFF0078D7), size: 28),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Días: ${_formatDays(reminder.selectedDays)}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ],

          const SizedBox(height: 16),

          Row(
            children: [
              const Icon(Icons.access_time, color: Color(0xFF26C46C), size: 28),
              const SizedBox(width: 10),
              Text(
                "Hora: ${reminder.dateTime.hour.toString().padLeft(2, '0')}:${reminder.dateTime.minute.toString().padLeft(2, '0')}",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: onClose,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF26C46C),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
          child: const Text(
            "Cerrar",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
