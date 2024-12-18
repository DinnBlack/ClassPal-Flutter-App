import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/widgets/common_widget/custom_app_bar.dart';
import '../../model/class_model.dart';

class ClassSchedulePage extends StatefulWidget {
  static const route = "ClassSchedulePage";
  final ClassModel classData;

  const ClassSchedulePage({super.key, required this.classData});

  @override
  State<ClassSchedulePage> createState() => _ClassSchedulePageState();
}

class _ClassSchedulePageState extends State<ClassSchedulePage> {
  List<Appointment> _appointments = [];
  List<Appointment> _selectedDayEvents = [];
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _initializeAppointments();
  }

  void _initializeAppointments() {
    _appointments = [
      Appointment(
        startTime: DateTime(2024, 12, 4, 8, 0), // 4/12/2024 8:00 AM
        endTime: DateTime(2024, 12, 4, 9, 0),   // 4/12/2024 9:00 AM
        subject: 'Mathematics Class',
        color: kPrimaryColor,
      ),
      Appointment(
        startTime: DateTime(2024, 12, 4, 12, 0), // 4/12/2024 12:00 PM
        endTime: DateTime(2024, 12, 4, 13, 0),   // 4/12/2024 1:00 PM
        subject: 'Physics Class',
        color: Colors.green,
      ),
      Appointment(
        startTime: DateTime(2024, 12, 4, 15, 0), // 4/12/2024 3:00 PM
        endTime: DateTime(2024, 12, 4, 16, 0),   // 4/12/2024 4:00 PM
        subject: 'Chemistry Class',
        color: Colors.red,
      ),
    ];                                                                             

    // Load today's events initially
    _selectedDayEvents = _getEventsForDay(_selectedDate);
  }

  List<Appointment> _getEventsForDay(DateTime selectedDate) {
    return _appointments
        .where((appointment) =>
    appointment.startTime.day == selectedDate.day &&
        appointment.startTime.month == selectedDate.month &&
        appointment.startTime.year == selectedDate.year)
        .toList();
  }

  void _onSelectionChanged(CalendarSelectionDetails details) {
    setState(() {
      if (details.date != null) {
        _selectedDate = details.date!;
        _selectedDayEvents = _getEventsForDay(_selectedDate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Lịch học',
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        titleStyle: AppTextStyle.bold(kTextSizeXl),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.bell, size: 20),
            onPressed: () {},
          ),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.ellipsis, size: 20),
            onPressed: () {},
          ),
        ],
        isTitleCenter: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SfCalendar(
              view: CalendarView.month,
              dataSource: AppointmentDataSource(_appointments),
              firstDayOfWeek: 1,
              todayHighlightColor: Colors.red,
              onSelectionChanged: _onSelectionChanged,
              headerStyle: const CalendarHeaderStyle(
                textAlign: TextAlign.center,
                backgroundColor: kPrimaryColor,
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              viewHeaderStyle: const ViewHeaderStyle(
                dayTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
                dateTextStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // Event Details for selected day
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(10),
              child: _selectedDayEvents.isEmpty
                  ? Center(
                child: Text(
                  'Không có sự kiện nào trong ngày này',
                  style: AppTextStyle.regular(kTextSizeLg),
                ),
              )
                  : ListView.builder(
                itemCount: _selectedDayEvents.length,
                itemBuilder: (context, index) {
                  final event = _selectedDayEvents[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 3,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: event.color,
                        child: const Icon(Icons.event,
                            color: Colors.white, size: 16),
                      ),
                      title: Text(
                        event.subject,
                        style: AppTextStyle.bold(kTextSizeLg),
                      ),
                      subtitle: Text(
                        "${event.startTime.hour.toString().padLeft(2, '0')}:${event.startTime.minute.toString().padLeft(2, '0')} - ${event.endTime.hour.toString().padLeft(2, '0')}:${event.endTime.minute.toString().padLeft(2, '0')}",
                        style: AppTextStyle.regular(kTextSizeMd),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
