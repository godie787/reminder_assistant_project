import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:reminder_assistant/constants/frecuencies.dart';
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

    void frecuencyAction(String value) {
      provider.setFrecuency(value);
    }

    void hourAction(DateTime time) {
      provider.setSelectedHour(time);
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF26C46C),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 54,
              color: Color(0xFFFFFFFF),
            ),
            onPressed: () {
              context.pop();
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
                  TitleInput(),
                  SizedBox(height: 16),
                  DescriptionInput(),
                  SizedBox(height: 36),
                  FrecuencyTitleAndDescription(),
                  SizedBox(height: 16),
                  FrecuencySection(
                      frecuencyAction: frecuencyAction, frecuency: frecuency),
                  SizedBox(height: 36),
                  HourTitleAndDescription(),
                  SizedBox(height: 16),
                  HourSection(hourAction: hourAction, hour: hour, minute: minute, amPm: amPm),
                  SizedBox(height: 36),
                  if (frecuency == Frecuencies.unique) ...[
                    DateTitleDescriptionAndDateSection(),
                  ],
                  if (frecuency == Frecuencies.weekly) ...[
                    DateTitleDescriptionAndDaysSection(provider: provider),
                  ],
                  SaveButton(),
                  SizedBox(height: 30),
                ],
              )),
        )),
      ),
    );
  }
}
