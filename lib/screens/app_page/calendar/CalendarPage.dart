import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert'; // 用來處理 JSON 編碼和解碼
import 'package:shared_preferences/shared_preferences.dart';//存在本地端

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  Map<DateTime, List<String>> events = {}; // 存放行程

  @override
  void initState() {
    super.initState();
    _loadEvents(); // 載入已儲存的行程
  }

  // 讀取事件
  void _loadEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? eventsString = prefs.getString('events');
    
    if (eventsString != null) {
      Map<String, dynamic> decodedEvents = jsonDecode(eventsString);
      setState(() {
        events = decodedEvents.map((key, value) {
          DateTime date = DateTime.parse(key);
          List<String> eventList = List<String>.from(value);
          return MapEntry(date, eventList);
        });
      });
    }
  }

  // 儲存事件
  void _saveEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedEvents = jsonEncode(events.map((key, value) {
      return MapEntry(key.toIso8601String(), value);
    }));
    await prefs.setString('events', encodedEvents); // 儲存事件
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  // 新增行程的跳出視窗
  void _showAddEventDialog(DateTime day) {
    TextEditingController eventController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("新增事件"),
        content: TextField(
          controller: eventController,
          decoration: InputDecoration(hintText: "輸入事件名稱"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("取消"),
          ),
          TextButton(
            onPressed: () {
              if (eventController.text.isNotEmpty) {
                setState(() {
                  events.putIfAbsent(day, () => []).add(eventController.text);
                  _saveEvents(); // 新增後儲存事件
                });
              }
              Navigator.pop(context);
            },
            child: Text("新增"),
          ),
        ],
      ),
    );
  }

  // 編輯行程的跳出視窗
  void _showEditEventDialog(DateTime day, int index) {
    TextEditingController eventController = TextEditingController(text: events[day]![index]);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("修改事件"),
        content: TextField(
          controller: eventController,
          decoration: InputDecoration(hintText: "修改事件名稱"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("取消"),
          ),
          TextButton(
            onPressed: () {
              if (eventController.text.isNotEmpty) {
                setState(() {
                  events[day]![index] = eventController.text;
                  _saveEvents(); // 修改後儲存事件
                });
              }
              Navigator.pop(context);
            },
            child: Text("修改"),
          ),
        ],
      ),
    );
  }

  // 刪除事件
  void _deleteEvent(DateTime day, int index) {
    setState(() {
      events[day]!.removeAt(index);
      if (events[day]!.isEmpty) {
        events.remove(day); // 移除沒有事件的日期
      }
      _saveEvents(); // 刪除後儲存事件
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime current = DateTime.now();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                "選取日期: ${today.toString().split(" ")[0]}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              TableCalendar(
                firstDay: DateTime.utc(current.year - 2, 01, 01),
                lastDay: DateTime.utc(current.year + 2, 12, 31),
                locale: "en_US",
                rowHeight: 35,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) => isSameDay(day, today),
                focusedDay: today,
                onDaySelected: _onDaySelected,
                eventLoader: (day) => events[day] ?? [],
                calendarStyle: CalendarStyle(
                  defaultTextStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  weekendTextStyle: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              if (events[today] != null)
                Column(
                  children: events[today]!
                      .asMap()
                      .entries
                      .map((entry) => Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.tertiary,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(entry.value),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                        Icons.edit_square,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    onPressed: () =>
                                        _showEditEventDialog(today, entry.key),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () =>
                                        _deleteEvent(today, entry.key),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              SizedBox(height: 5),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _showAddEventDialog(today),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:Theme.of(context).colorScheme.tertiary,
                    elevation: 5,
                    shadowColor: Colors.black45,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: Icon(
                    Icons.event,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  label: Text(
                    "新增行程",
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:intl/intl.dart';
// import 'package:test_app/screens/app_page/calendar/floatbtnFirst.dart';
// // import 'package:test_app/component/defaultContainer.dart';
// class Event {
//   final String title;
//   Event(this.title);

//   @override
//   String toString() => title;
// }
// class CalendarPage extends StatefulWidget {
//   const CalendarPage({super.key});

//   @override
//   CalendarPageState createState() => CalendarPageState();
// }

// class CalendarPageState extends State<CalendarPage> {
//   DateTime _selectedDay = DateTime.now();
//   DateTime _focusedDay = DateTime.now();

//   //事件列表(測試用)
//   final Map<DateTime, List<Event>> events = {
//     DateTime.utc(2025, 01, 17):[Event('Meeting with client')],
//     DateTime.utc(2025, 01, 20):[Event('Project deadline')],
//   };

//   List<Event> _getEventsForDay(DateTime day){
//     final normalizedDay = DateTime.utc(day.year, day.month, day.day);
//     return events[normalizedDay] ?? [];
//   } 

//   @override
//   Widget build(BuildContext context) {
//     DateTime current = DateTime.now();
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Center(
//                 child: TableCalendar(
//                   firstDay: DateTime.utc(current.year - 2, 01, 01),
//                   lastDay: DateTime.utc(current.year + 2, 12, 31),
//                   focusedDay: _focusedDay,

//                   //以月為單位顯示
//                   availableCalendarFormats: const {
//                     CalendarFormat.month: 'Month', 
//                   },

//                   selectedDayPredicate: (day){
//                     return isSameDay(_selectedDay, day);
//                   },
//                   onDaySelected: (selectedDay, focusedDay){
//                     setState(() {
//                       _selectedDay = selectedDay;
//                       _focusedDay = focusedDay;
//                     });
//                   },
                  
//                   //最上方月份家年份大標
//                   headerStyle: HeaderStyle(
//                     // formatButtonVisible: false, // 隱藏格式切換按鈕（可選）
//                     titleCentered: true, // 讓標題置中
//                     titleTextStyle: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Theme.of(context).colorScheme.primary, // 修改月份標題的顏色
//                     ),
//                   ),

//                   //日期顏色
//                   calendarStyle: CalendarStyle(
//                     defaultTextStyle: TextStyle(
//                       color: Theme.of(context).colorScheme.primary,//平日數字顏色
//                     ),
//                     weekendTextStyle: const TextStyle(
//                       color: Colors.red, // 週六日的數字顏色
//                     ),
//                   ),
                  
//                   //星期的顏色
//                   calendarBuilders: CalendarBuilders(
//                     dowBuilder: (context, day) {
//                       final text = DateFormat.E().format(day);
//                       return Center(
//                         child: Text(
//                           text,
//                           style: TextStyle(
//                             color: day.weekday == DateTime.sunday || day.weekday == DateTime.saturday
//                               ?Colors.red
//                               :Theme.of(context).colorScheme.primary,
//                           ),
//                         ),
//                       );
//                     }
//                   ),

//                   //事件顯示
//                   eventLoader: _getEventsForDay,

//                 ),
//               )
//             ),
//             //顯示事件
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               margin: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 5,
//                     spreadRadius: 2,
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     DateFormat('yyyy年MM月dd日').format(_selectedDay),
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   _getEventsForDay(_selectedDay).isEmpty
//                       ? Text('沒有事件', style: TextStyle(color: Colors.grey))
//                       : Column(
//                           children: _getEventsForDay(_selectedDay)
//                             .map((event) => ListTile(
//                                   title: Text(event.title),
//                                 ))
//                             .toList(),
//                         ),
//                 ],
//               ),
//             ),
//             //data方塊
//             // Container(
//             //   width: double.infinity,
//             //   padding: const EdgeInsets.all(0),
//             //   margin: const EdgeInsets.all(10),
//             //   decoration: BoxDecoration(
//             //     boxShadow: [
//             //       BoxShadow(
//             //         color: Colors.black.withOpacity(0.1),
//             //         blurRadius: 5,
//             //         spreadRadius: 2,
//             //       ),
//             //     ],
//             //   ),
//             //   child: CustomContainer(
//             //     height: 100,
//             //     child: Padding(
//             //       padding: EdgeInsets.all(16),
//             //       child: Text('data'),
//             //     ),
//             //   ),
//             // ),
                      
//           ],
//         )
//       ),
//       //浮動的新增日記、數據按鈕
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.edit, color: Colors.white),
//         onPressed: (){
//           FloatbtnFirst(context); //底部跳出視窗(日記、數據紀錄)
//         },
//         backgroundColor: Theme.of(context).primaryColor,
//       ),
//     );
//   }
// }
