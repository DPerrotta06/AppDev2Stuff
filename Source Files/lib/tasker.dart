import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/task.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Basic Notifications',
      channelDescription: 'Notification channel for basic tests',
      defaultColor: Colors.indigo,
      ledColor: Colors.white,
      importance: NotificationImportance.High,
    ),
  ]);
  runApp(MaterialApp(home: Tasker(), debugShowCheckedModeBanner: false));
}

class Tasker extends StatefulWidget {
  const Tasker({super.key});

  @override
  State<Tasker> createState() => _TaskerState();
}

class _TaskerState extends State<Tasker> {
  DateTime currentDate = DateTime.now();
  final String _dateDay = DateFormat.d().format(DateTime.now());
  final String _dateMonth = DateFormat.MMMM().format(DateTime.now());
  final String _dateYear = DateFormat.y().format(DateTime.now());
  final String _weekDay = DateFormat.EEEE().format(DateTime.now());
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    requestNotifsPermission();
  }

  void requestNotifsPermission() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  void createNotif(String title, String body) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: title,
        body: body,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text(
            'Tasker',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(36),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 19),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            _dateDay,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                _dateMonth,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _dateYear,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        _weekDay,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      body: _taskList(),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.lightBlue,
        onPressed: () => _addTaskSheet(context),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Future<void> _editTaskSheet(
    BuildContext context,
    Task task,
    int index,
  ) async {
    TextEditingController editController = TextEditingController(
      text: task.description,
    );
    DateTime? selectedDate = task.dueDate == null
        ? null
        : DateFormat.yMMMd().parse(task.dueDate!);
    final updatedTask = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) {
        return Container(
          color: Colors.indigo,
          child: StatefulBuilder(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          TextField(
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 22,
                            ),
                            controller: editController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Edit task',
                              hintStyle: TextStyle(
                                color: Colors.lightBlue,
                                fontSize: 22,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  final picked = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(2022),
                                    lastDate: DateTime(2050),
                                    initialDate: selectedDate ?? DateTime.now(),
                                  );
                                  if (picked != null) {
                                    state(() => selectedDate = picked);
                                  }
                                },
                                icon: Icon(
                                  Icons.calendar_month,
                                  color: Colors.lightBlue,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          if (selectedDate != null)
                            TextButton(
                              onPressed: () => state(() => selectedDate = null),
                              child: Text(
                                "Remove due date",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue,
                            ),
                            onPressed: () {
                              Navigator.pop(context, {
                                'desc': editController.text,
                                'date': selectedDate == null
                                    ? null
                                    : DateFormat.yMMMd().format(selectedDate!),
                              });
                            },
                            child: Text(
                              'Save Changes',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
    if (updatedTask != null) {
      setState(() {
        tasks[index].description = updatedTask['desc'];
        tasks[index].dueDate = updatedTask['date'];
      });
    }
  }

  Widget _taskList() {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Column(
          children: [
            ListTile(
              leading: Transform.scale(
                scale: 1.5,
                child: Checkbox(
                  checkColor: Colors.white,
                  activeColor: Colors.lightBlue,
                  shape: CircleBorder(),
                  value: task.isCompleted,
                  onChanged: (value) => setState(() {
                    task.isCompleted = value!;
                    if (value == true) {
                      createNotif(
                        'Task complete!',
                        'You completed: ${task.description}',
                      );
                    }
                  }),
                ),
              ),
              title: Text(
                task.description,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: task.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: task.isCompleted ? Colors.grey : Colors.black,
                  decorationColor: task.isCompleted ? Colors.grey : Colors.grey,
                  decorationThickness: task.isCompleted ? 2 : 0,
                ),
              ),
              subtitle: Text(_dueText(task)),
              trailing: IconButton(
                icon: Icon(Icons.sell, color: Colors.lightBlue),
                onPressed: () {
                  _editTaskSheet(context, task, index);
                },
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey.shade300,
              indent: 16,
              endIndent: 16,
            ),
          ],
        );
      },
    );
  }

  Future<void> _addTaskSheet(BuildContext context) async {
    final newTask = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) {
        return _sheetForm(context);
      },
    );
    if (newTask != null) {
      setState(() {
        tasks.add(
          Task(
            description: newTask['desc'],
            dueDate: newTask['date'],
            isCompleted: false,
          ),
        );
      });
      createNotif(
        'New task has been added!',
        '${newTask['desc']} has been added!',
      );
    }
  }

  Widget _sheetForm(BuildContext context) {
    TextEditingController taskDescController = TextEditingController();
    return Container(
      color: Colors.indigo,
      child: StatefulBuilder(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                ),
                SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      TextField(
                        style: TextStyle(color: Colors.lightBlue, fontSize: 22),
                        controller: taskDescController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter a new task',
                          hintStyle: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 22,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => _selectDate(context),
                            icon: Icon(
                              Icons.calendar_month,
                              color: Colors.lightBlue,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                        ),
                        onPressed: () {
                          Navigator.pop(context, {
                            'desc': taskDescController.text,
                            'date': DateFormat.yMMMd().format(currentDate),
                          });
                        },
                        child: Text(
                          'Add Task',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2022),
      lastDate: DateTime(2050),
    );
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
      });
    }
  }

  int _getRemainingDay(String deadline) {
    DateTime due = DateFormat.yMMMd().parse(deadline);
    DateTime now = DateTime.now();
    int remainingDays = due.difference(now).inDays;
    if (remainingDays == 0) {
      createNotif('Task due today!', '$deadline is due today!');
    }
    return remainingDays;
  }

  String _dueText(Task task) {
    if (task.dueDate == null) {
      return '';
    }
    if (_getRemainingDay(task.dueDate!) == 0) {
      return 'Due Today';
    }
    if (_getRemainingDay(task.dueDate!) > 0) {
      return 'Due in ${_getRemainingDay(task.dueDate!)} day(s)';
    }
    return 'Overdue by ${_getRemainingDay(task.dueDate!).abs()} day(s)';
  }
}
