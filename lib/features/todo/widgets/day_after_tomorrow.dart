import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_with_riverpod/features/todo/controllers/todo/todo_provider.dart';
import 'package:todo_with_riverpod/features/todo/widgets/todo_tile.dart';

import '../../../common/models/task_model.dart';
import '../../../common/widgets/expansion_tile.dart';
import '../controllers/xpansion_provider.dart';

class TommorowsList extends ConsumerWidget {
  const TommorowsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);
    var color = ref.read(todoStateProvider.notifier).getRandomColor();
    String dayAftertomorrow =
        ref.watch(todoStateProvider.notifier).getTDayAfteromorrow();
    List<Task> tomorrowTasks = todos
        .where((task) =>
            task.isCompleted == 0 && task.date!.contains(dayAftertomorrow))
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
              )
            : const Icon(
                AntDesign.closecircleo,
              ),
      ),
      children: [
        for (final todo in tomorrowTasks)
          TodoTile(
            title: todo.title,
            description: todo.desc,
            start: todo.startTime,
            end: todo.endTime,
            color: color,
            delete: () =>
                ref.read(todoStateProvider.notifier).deleteItem(todo.id ?? 0),
            editWidget: GestureDetector(
              onTap: () {},
              child: const Icon(MaterialCommunityIcons.circle_edit_outline),
            ),
            switcher: const SizedBox.shrink(),
          ),
      ],
    );
  }
}
