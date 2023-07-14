import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_with_riverpod/common/helpers/notifications_helper.dart';
import 'package:todo_with_riverpod/common/utils/constants.dart';
import 'package:todo_with_riverpod/common/widgets/custom_otn_btn.dart';
import 'package:todo_with_riverpod/common/widgets/custom_text_field.dart';
import 'package:todo_with_riverpod/common/widgets/hieght_spacer.dart';
import 'package:todo_with_riverpod/common/widgets/show_dialog.dart';
import 'package:todo_with_riverpod/common/widgets/text_style.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:todo_with_riverpod/features/todo/controllers/dates/dates_provider.dart';
import 'package:todo_with_riverpod/features/todo/controllers/todo/todo_provider.dart';
import 'package:todo_with_riverpod/features/todo/pages/home_page.dart';

import '../../../common/models/task_model.dart';

class AddTask extends ConsumerStatefulWidget {
  const AddTask({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskState();
}

class _AddTaskState extends ConsumerState<AddTask> {
  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();
  List<int> notification = [];
  late NotificationsHelper notifiHelper;
  late NotificationsHelper controller;

  @override
  void initState() {
    log('initState');
    notifiHelper = NotificationsHelper(ref: ref);

    Future.delayed(const Duration(seconds: 0), () {
      controller = NotificationsHelper(ref: ref);
      controller.initializeNotification();
    });

    notifiHelper.initializeNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scheduleDate = ref.watch(dateStateProvider);
    final start = ref.watch(startTimeStateProvider);
    final finish = ref.watch(finishTimeStateProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: ListView(
          children: [
            const HeightSpacer(height: 20),
            CustomTextField(
              hintText: 'Add title',
              hintStyle: appStyle(16, Appconst.kGreyLight, FontWeight.w600),
              controller: title,
            ),
            const HeightSpacer(height: 20),
            CustomTextField(
              hintText: 'Add description',
              hintStyle: appStyle(16, Appconst.kGreyLight, FontWeight.w600),
              controller: desc,
            ),
            const HeightSpacer(height: 20),
            CustomOtlBtn(
                onTap: () async {
                  await picker.DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2023, 6, 5),
                      maxTime: DateTime(2050, 6, 7),
                      theme: const picker.DatePickerTheme(
                          doneStyle:
                              TextStyle(color: Appconst.kGreen, fontSize: 16)),
                      onConfirm: (date) {
                    final String chosenDate = date.toString().substring(0, 10);
                    ref.read(dateStateProvider.notifier).setDate(chosenDate);
                  }, currentTime: DateTime.now(), locale: picker.LocaleType.he);
                },
                width: Appconst.kWidth,
                height: 52.h,
                color: Appconst.kLight,
                color2: Appconst.kBlueLight,
                text: scheduleDate.isEmpty ? 'Set Date' : scheduleDate),
            const HeightSpacer(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomOtlBtn(
                    onTap: () {
                      picker.DatePicker.showDateTimePicker(context,
                          showTitleActions: true, onConfirm: (date) {
                        ref
                            .read(startTimeStateProvider.notifier)
                            .setStart(date.toString());

                        notification = ref
                            .read(startTimeStateProvider.notifier)
                            .dates(date);
                      });
                    },
                    width: Appconst.kWidth * 0.4,
                    height: 52.h,
                    color: Appconst.kLight,
                    color2: Appconst.kBlueLight,
                    text:
                        start.isEmpty ? 'Start Time' : start.substring(10, 16)),
                CustomOtlBtn(
                    onTap: () {
                      picker.DatePicker.showDateTimePicker(context,
                          showTitleActions: true, onConfirm: (date) {
                        ref
                            .read(finishTimeStateProvider.notifier)
                            .setStart(date.toString());
                      });
                    },
                    width: Appconst.kWidth * 0.4,
                    height: 52.h,
                    color: Appconst.kLight,
                    color2: Appconst.kBlueLight,
                    text:
                        finish.isEmpty ? 'End Time' : finish.substring(10, 16)),
              ],
            ),
            const HeightSpacer(height: 20),
            CustomOtlBtn(
                onTap: () {
                  if (title.text.isNotEmpty &&
                      desc.text.isNotEmpty &&
                      scheduleDate.isNotEmpty &&
                      start.isNotEmpty &&
                      finish.isNotEmpty) {
                    Task task = Task(
                        title: title.text,
                        desc: desc.text,
                        isCompleted: 0,
                        date: scheduleDate,
                        startTime: start.substring(10, 16),
                        endTime: finish.substring(10, 16),
                        remind: 0,
                        repeat: "yes");

                    notifiHelper.scheduledNotification(
                        notification[0],
                        notification[1],
                        notification[2],
                        notification[3],
                        task);
                    ref.read(todoStateProvider.notifier).addItem(task);
                    ref.read(dateStateProvider.notifier).setDate("");
                    ref.read(startTimeStateProvider.notifier).setStart("");
                    ref.read(finishTimeStateProvider.notifier).setStart("");

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ));
                  } else {
                    showAlertDialog(
                        context: context, message: 'Failed to add a task');
                  }
                },
                width: Appconst.kWidth,
                height: 52.h,
                color: Appconst.kLight,
                color2: Appconst.kGreen,
                text: 'Submit'),
          ],
        ),
      ),
    );
  }
}
