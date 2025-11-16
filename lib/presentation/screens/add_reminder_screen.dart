import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:reminder_assistant/constants/frecuencies.dart';
import 'package:reminder_assistant/domain/entities/reminder/reminder.dart';
import 'package:reminder_assistant/presentation/widgets/add_reminder/date_title_description_and_date_section.dart';
import 'package:reminder_assistant/presentation/widgets/add_reminder/date_title_description_and_days_section.dart';
import 'package:reminder_assistant/presentation/widgets/add_reminder/description_input.dart';
import 'package:reminder_assistant/presentation/widgets/add_reminder/frecuency_section.dart';
import 'package:reminder_assistant/presentation/widgets/add_reminder/frecuency_title_and_description.dart';
import 'package:reminder_assistant/presentation/widgets/add_reminder/hour_section.dart';
import 'package:reminder_assistant/presentation/widgets/add_reminder/hour_title_and_description.dart';
import 'package:reminder_assistant/presentation/widgets/add_reminder/save_button.dart';
import 'package:reminder_assistant/presentation/widgets/add_reminder/title_input.dart';
import 'package:reminder_assistant/providers/reminder_provider.dart';

class AddReminderScreen extends StatelessWidget {
  const AddReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReminderProvider>();
    final frecuency = provider.frecuency;
    final hour = provider.selectedTime.hour;
    final minute = provider.selectedTime.minute;
    final amPm = provider.amPm;
    final isAdding = provider.isAdding;

    TextEditingController titleController =
        TextEditingController(text: provider.title);
    TextEditingController descriptionController =
        TextEditingController(text: provider.description);

    void frecuencyAction(String value) {
      provider.setFrecuency(value);
    }

    void hourAction(DateTime time) {
      provider.setSelectedHour(time);
    }

    void saveReminder() {
      provider.setTitle(titleController.text);
      provider.setDescription(descriptionController.text);

      provider.addReminder(Reminder(
        id: 123,
        title: titleController.text,
        description: descriptionController.text,
        frequency: frecuency,
        dateTime: provider.selectedTime,
        status: 'active',
        selectedDays: provider.selectedDays,
      ));
      context.push('/');
    }

    void setTitleAction(String value) {
      provider.setTitle(value);
    }

    void setDescriptionAction(String value) {
      provider.setDescription(value);
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: isAdding ? Color(0xFF26C46C) : Color(0xFFD97015),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 54,
              color: Color(0xFFFFFFFF),
            ),
            onPressed: () {
              context.push('/');
              provider.resetAllStates();
            },
          ),
        ),
        body: Expanded(
            child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  TitleInput(
                      titleController: titleController,
                      setTitleAction: setTitleAction),
                  SizedBox(height: 16),
                  DescriptionInput(
                      descriptionController: descriptionController,
                      setDescriptionAction: setDescriptionAction),
                  SizedBox(height: 36),
                  FrecuencyTitleAndDescription(),
                  SizedBox(height: 16),
                  FrecuencySection(
                      frecuencyAction: frecuencyAction, frecuency: frecuency),
                  SizedBox(height: 36),
                  HourTitleAndDescription(),
                  SizedBox(height: 16),
                  HourSection(
                      hourAction: hourAction,
                      hour: hour,
                      minute: minute,
                      amPm: amPm),
                  SizedBox(height: 36),
                  if (frecuency == Frecuencies.unique) ...[
                    DateTitleDescriptionAndDateSection(),
                  ],
                  if (frecuency == Frecuencies.weekly) ...[
                    DateTitleDescriptionAndDaysSection(provider: provider),
                  ],
                  SaveButton(saveReminder: saveReminder),
                  SizedBox(height: 30),
                ],
              )),
        )),
      ),
    );
  }
}
