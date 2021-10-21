import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_note/controllers/task_controller.dart';
import 'package:my_note/models/task.dart';
import 'package:my_note/models/theme.dart';
import 'package:my_note/widgets/button.dart';
import 'package:my_note/widgets/input_fields.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime =
      DateFormat("hh:mm a").format(DateTime.now()).toString(); //a - AM or PM
  String _endTime = "9.30 PM";
  //remind list
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20, 25, 30];
  //reapt list
  String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly", "Yearly"];
  //selected color
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: context.theme.canvasColor,
      appBar: _appBar(context),
      body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add task",
                  style: headingStyle,
                ),
                InputFields(
                    title: "Title",
                    hint: "Enter task title",
                    controller: _titleController),
                InputFields(
                    title: "Note",
                    hint: "Enter your note",
                    controller: _noteController),
                InputFields(
                  title: "Date",
                  hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                    onPressed: () {
                      _getDateFromUser();
                    },
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputFields(
                        title: "Start Time",
                        hint: _startTime,
                        widget: IconButton(
                          onPressed: () {
                            _getTimeFromUser(isStartTime: true);
                          },
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InputFields(
                        title: "End Time",
                        hint: _endTime,
                        widget: IconButton(
                          onPressed: () {
                            _getTimeFromUser(isStartTime: false);
                          },
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                InputFields(
                  title: "Remind",
                  hint: "$_selectedRemind minitues early",
                  widget: DropdownButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 6,
                    style: subTitleStyle,
                    underline: Container(height: 0),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRemind = int.parse(newValue!);
                      });
                    },
                    items:
                        remindList.map<DropdownMenuItem<String>>((int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString()),
                      );
                    }).toList(),
                  ),
                ),
                InputFields(
                  title: "Reapt",
                  hint: "$_selectedRepeat",
                  widget: DropdownButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 6,
                    style: subTitleStyle,
                    underline: Container(height: 0),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRepeat = newValue!;
                      });
                    },
                    items: repeatList
                        .map<DropdownMenuItem<String>>((String? value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value!,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _colorPallete(),
                    MyButon(lable: "Crate Task", onTap: () => _validateData())
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          )),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: const Icon(
          Icons.arrow_back_ios,
          size: 20.0,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage("images/user.png"),
        ),
        SizedBox(
          width: 20.0,
        )
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDarte = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );
    if (_pickerDarte != null) {
      setState(() {
        _selectedDate = _pickerDarte;
      });
    } else {
      print("something wntwrong");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("time canceld");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        // normal time format -----> 12.15 AM
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
    );
  }

  _colorPallete() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Color",
        style: titleStyle,
      ),
      const SizedBox(height: 8.0),
      //helps to put things in horizontal line
      Wrap(
          children: List<Widget>.generate(3, (int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedColor = index;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: index == 0
                  ? Colors.blueAccent
                  : index == 1
                      ? Colors.pinkAccent
                      : Colors.greenAccent,
              child: _selectedColor == index
                  ? const Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 16,
                    )
                  : Container(),
            ),
          ),
        );
      }))
    ]);
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      // add to database
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar("Requried", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.black,
          backgroundColor: Colors.grey[300],
          margin: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
          padding: const EdgeInsets.all(5),
          borderRadius: 20,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.black,
          ));
    }
  }

  _addTaskToDb() async {
    int value = await _taskController.addTask(
      task: Task(
        note: _noteController.text,
        title: _titleController.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        remind: _selectedRemind,
        repeat: _selectedRepeat,
        color: _selectedColor,
        isCompleted: 0,
      ),
    );
    print("My id is "+"$value");
  }
}
