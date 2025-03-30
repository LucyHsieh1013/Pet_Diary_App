import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

class AddRecord extends StatefulWidget {
  @override
  _AddRecordState createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  DateTime selectedDate = DateTime.now();
  String amount = "0";

  void _onKeyboardTap(String value) {
    setState(() {
      if (amount == "0") {
        amount = value;
      } else {
        amount += value;
      }
    });
  }

  void _clearAmount() {
    setState(() {
      amount = "0";
    });
  }

  void _deleteLastDigit() {
    setState(() {
      if (amount.length > 1) {
        amount = amount.substring(0, amount.length - 1);
      } else {
        amount = "0";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新紀錄"),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text("儲存", style: TextStyle(color: Colors.white)),
          ),
        ],
        backgroundColor: Colors.brown[300],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.brown[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      onConfirm: (date) {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                      currentTime: selectedDate,
                      locale: LocaleType.zh,
                    );
                  },
                  child: Text(
                    "${selectedDate.year}年${selectedDate.month}月${selectedDate.day}日 ${selectedDate.hour}:${selectedDate.minute}",
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.brown[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("飲水量", style: TextStyle(fontSize: 20)),
                Text("$amount ml", style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          Expanded(
            child: NumericKeyboard(
              onKeyboardTap: _onKeyboardTap,
              rightButtonFn: _deleteLastDigit,
              rightIcon: Icon(Icons.backspace, color: Colors.white),
              leftButtonFn: _clearAmount,
              leftIcon: Icon(Icons.close, color: Colors.white),
              textColor: Colors.black,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          ),
        ],
      ),
    );
  }
}
