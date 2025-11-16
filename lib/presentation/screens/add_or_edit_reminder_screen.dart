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

class AddOrEditReminderScreen extends StatelessWidget {
  final int? reminderId;
  const AddOrEditReminderScreen({super.key, this.reminderId});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ReminderProvider>();
    final watchProvider = context.watch<ReminderProvider>();
    final frecuency = context.select((ReminderProvider p) => p.frecuency);
    final hour = context.select((ReminderProvider p) => p.selectedTime.hour);
    final minute =
        context.select((ReminderProvider p) => p.selectedTime.minute);
    final amPm = context.select((ReminderProvider p) => p.amPm);
    final isAdding = context.select((ReminderProvider p) => p.isAdding);
    final isEditing = context.select((ReminderProvider p) => p.isEditing);
    final titleController = provider.titleController;
    final descriptionController = provider.descriptionController;
    
    void frecuencyAction(String value) {
      provider.setFrecuency(value);
    }

    void hourAction(DateTime time) {
      provider.setSelectedHour(time);
    }

    void saveOrEditReminder() {
      provider.setTitle(titleController.text);
      provider.setDescription(descriptionController.text);

      if (isEditing && reminderId != null) {
        provider.editReminder(
          Reminder(
            id: reminderId!,
            title: provider.title,
            description: provider.description,
            frequency: provider.frecuency,
            dateTime: provider.selectedTime,
            status: 'active',
            selectedDays: provider.selectedDays,
          ),
        );
      } else if (isAdding) {
        provider.addReminder(
          Reminder(
            id: 0,
            title: provider.title,
            description: provider.description,
            frequency: provider.frecuency,
            dateTime: provider.selectedTime,
            status: 'active',
            selectedDays: provider.selectedDays,
          ),
        );
      }

      provider.resetAllStates();
      context.go('/home');
    }

    void setTitleAction(String value) {
      provider.setTitle(value);
    }

    void setDescriptionAction(String value) {
      provider.setDescription(value);
    }

    if (reminderId != null && provider.title.isEmpty) {
      Future.microtask(() {
        provider.loadReminderData(reminderId!);
      });
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: isAdding
              ? Color(0xFF26C46C)
              : isEditing
                  ? Color(0xFFD97015)
                  : Color(0xFF26C46C),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 54,
              color: Color(0xFFFFFFFF),
            ),
            onPressed: () {
              context.go('/home');
              provider.resetAllStates();
              provider.resetReminderForm();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  TitleInput(
                      titleController: provider.titleController,
                      setTitleAction: setTitleAction),
                  SizedBox(height: 16),
                  DescriptionInput(
                      descriptionController: provider.descriptionController,
                      setDescriptionAction: setDescriptionAction),
                  SizedBox(height: 36),
                  FrecuencyTitleAndDescription(),
                  SizedBox(height: 16),
                  FrecuencySection(
                      frecuencyAction: frecuencyAction,
                      frecuency: frecuency,
                      isEditing: isEditing,
                      isAdding: isAdding),
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
                    DateTitleDescriptionAndDaysSection(provider: watchProvider),
                  ],
                  SaveButton(
                    saveOrEditReminder: saveOrEditReminder,
                    isAdding: isAdding,
                    isEditing: isEditing,
                    isDisabled:
                        !provider.isTitleValid || provider.title.isEmpty,
                  ),
                  SizedBox(height: 30),
                ],
              )),
        ),
      ),
    );
  }
}
