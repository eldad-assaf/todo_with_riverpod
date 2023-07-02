import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_with_riverpod/common/utils/constants.dart';
import 'package:todo_with_riverpod/common/widgets/custom_otn_btn.dart';
import 'package:todo_with_riverpod/common/widgets/custom_text_field.dart';
import 'package:todo_with_riverpod/common/widgets/hieght_spacer.dart';
import 'package:todo_with_riverpod/common/widgets/text_style.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:todo_with_riverpod/features/todo/controllers/dates/dates_provider.dart';

class AddTask extends ConsumerStatefulWidget {
  const AddTask({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskState();
}

class _AddTaskState extends ConsumerState<AddTask> {
  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final date = ref.watch(dateStateProvider);
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
                text: date.isEmpty ? 'Set Date' : date),
            const HeightSpacer(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomOtlBtn(
                    onTap: () {},
                    width: Appconst.kWidth * 0.4,
                    height: 52.h,
                    color: Appconst.kLight,
                    color2: Appconst.kBlueLight,
                    text: 'Start Time'),
                CustomOtlBtn(
                    onTap: () {},
                    width: Appconst.kWidth * 0.4,
                    height: 52.h,
                    color: Appconst.kLight,
                    color2: Appconst.kBlueLight,
                    text: 'End Time'),
              ],
            ),
            const HeightSpacer(height: 20),
            CustomOtlBtn(
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
