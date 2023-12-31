import 'dart:math';

import 'package:todo_with_riverpod/common/helpers/db_helper.dart';
import 'package:todo_with_riverpod/common/models/task_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../common/utils/constants.dart';

part 'todo_provider.g.dart';

@riverpod
class TodoState extends _$TodoState {
  @override
  List<Task> build() {
    return [];
  }

  void refresh() async {
    final data = await DbHelper.getItems();
    state = data.map((e) => Task.fromJson(e)).toList();
  }

  void addItem(Task task) async {
    await DbHelper.createItem(task);
    refresh();
  }

  dynamic getRandomColor() {
    Random random = Random();
    int randomindex = random.nextInt(colors.length);
    return colors[randomindex];
  }

  void updateItem(int id, String title, String desc, int isCompleted,
      String date, String startTime, String endTime) async {
    await DbHelper.updateItem(
        id, title, desc, isCompleted, date, startTime, endTime);
    refresh();
  }

  void deleteItem(int id) async {
    await DbHelper.deleteItem(id);
    refresh();
  }

  void markAsCompleted(int id, String title, String desc, int isCompleted,
      String date, String startTime, String endTime) async {
    await DbHelper.updateItem(id, title, desc, 1, date, startTime, endTime);
    refresh();
  }

  String getToday() {
    DateTime today = DateTime.now();
    return today.toString().substring(0, 10);
  }

  String getTomorrow() {
    DateTime tommorow = DateTime.now().add(const Duration(days: 1));
    return tommorow.toString().substring(0, 10);
  }

  String getDayAfterTomorrow() {
    DateTime tommorow = DateTime.now().add(const Duration(days: 2));
    return tommorow.toString().substring(0, 10);
  }

  List<String> last30days() {
    DateTime today = DateTime.now();
    DateTime oneMonthAgo = today.subtract(const Duration(days: 30));

    List<String> dates = [];

    for (int i = 0; i < 30; i++) {
      DateTime date = oneMonthAgo.add(Duration(days: i));
      dates.add(date.toString().substring(0, 10));
    }
    return dates;
  }

  bool getStatus(Task data) {
    bool? isCompleted;
    if (data.isCompleted == 0) {
      isCompleted = false;
    } else {
      isCompleted = true;
    }
    return isCompleted;
  }
}
