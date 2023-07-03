import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_with_riverpod/features/todo/controllers/todo/todo_provider.dart';
import 'package:todo_with_riverpod/features/todo/widgets/todo_tile.dart';

import '../../../common/models/task_model.dart';
import '../../../common/utils/constants.dart';
import '../../../common/widgets/expansion_tile.dart';
import '../controllers/xpansion_provider.dart';

class TommorowsList extends ConsumerWidget {
  const TommorowsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);
    String tomorrow = ref.watch(todoStateProvider.notifier).getTomorrow();
    List<Task> tomorrowTasks = todos
        .where((task) => task.isCompleted == 0 && task.date!.contains(tomorrow))
        .toList();
    return XpansionTile(
      text: "Tomorrow's Task",
      text2: "Tomorrow's tasks are shown here",
      onExpansionChanged: (bool expanded) {
        ref.read(xpansionStateProvider.notifier).setStart(!expanded);
      },
      trailing: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: ref.watch(xpansionStateProvider)
            ? const Icon(
                AntDesign.circledown,
                color: Appconst.kLight,
              )
            : const Icon(
                AntDesign.closecircleo,
                color: Appconst.kBlueLight,
              ),
      ),
      children: [
        TodoTile(
          start: "03:00",
          end: "05:00",
          switcher: Switch(value: true, onChanged: (value) {}),
        )
      ],
    );
  }
}
