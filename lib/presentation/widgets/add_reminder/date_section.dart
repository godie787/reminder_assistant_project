import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_assistant/providers/reminder_provider.dart';

class DateSection extends StatelessWidget {
  const DateSection({super.key});

  Future<void> _selectDate(BuildContext context) async {
    final provider = context.read<ReminderProvider>();

    final picked = await showDatePicker(
      context: context,
      initialDate: provider.selectedTime,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      helpText: "Seleccionar fecha",
      confirmText: "Aceptar",
      cancelText: "Cancelar",
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF0078D7),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFF0078D7),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      provider.setSelectedDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReminderProvider>();
    final date = provider.selectedTime;

    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();

    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Row(
        children: [
          Expanded(
            child: _dateBox(day),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _dateBox(month),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _dateBox(year),
          ),
        ],
      ),
    );
  }

  Widget _dateBox(String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Color(0xffE5E5E5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
