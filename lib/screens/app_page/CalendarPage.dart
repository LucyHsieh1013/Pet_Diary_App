import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
class Event {
  final String title;
  Event(this.title);

  @override
  String toString() => title;
}
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  //事件列表(測試用)
  final Map<DateTime, List<Event>> events = {
    DateTime.utc(2025, 01, 17):[Event('Meeting with client')],
    DateTime.utc(2025, 01, 20):[Event('Project deadline')],
  };
  
  List<Event> _getEventsForDay(DateTime day){
    final normalizedDay = DateTime.utc(day.year, day.month, day.day);
    return events[normalizedDay] ?? [];
  } 

  @override
  Widget build(BuildContext context) {
    DateTime current = DateTime.now();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: TableCalendar(
              firstDay: DateTime.utc(current.year - 2, 01, 01),
              lastDay: DateTime.utc(current.year + 2, 12, 31),
              focusedDay: _focusedDay,
              availableCalendarFormats: const {
                CalendarFormat.month: 'Month',
              },
              selectedDayPredicate: (day){
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay){
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              eventLoader: _getEventsForDay,
              calendarBuilders: CalendarBuilders(
                dowBuilder: (context, day) {
                  final text = DateFormat.E().format(day);
                  return Center(
                    child: Text(
                      text,
                      style: TextStyle(
                        color: day.weekday == DateTime.sunday || day.weekday == DateTime.saturday
                          ?Colors.red
                          :Colors.black
                      ),
                    ),
                  );
                }
              ),
            ),
          )
        ),
        //顯示事件
        Expanded(
          child: _getEventsForDay(_selectedDay).isEmpty
            ? const Center(child: Text('沒有事件'))
            :ListView(//可滾動widget
              children: _getEventsForDay(_selectedDay)
              .map((event) => ListTile(
                title: Text(event.title),
              ))
              .toList(),
          ),
        ),
      ]
    );
    
  }
}
