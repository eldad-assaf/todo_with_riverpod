import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_with_riverpod/common/utils/constants.dart';
import 'package:todo_with_riverpod/features/todo/widgets/todo_tile.dart';

import '../../../common/models/task_model.dart';
import '../controllers/todo/todo_provider.dart';

class CompletedTasks extends ConsumerWidget {
  const CompletedTasks({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Task> listData = ref.watch(todoStateProvider);
    List lastMonth = ref.read(todoStateProvider.notifier).last30days();

    List<Task> completedList = listData
        .where((task) =>
            task.isCompleted == 1 ||
            lastMonth.contains(task.date!.substring(0, 10)))
        .toList();

    return ListView.builder(
      itemCount: completedList.length,
      itemBuilder: (context, index) {
        final data = completedList[index];
        dynamic color = ref.read(todoStateProvider.notifier).getRandomColor();
        return TodoTile(
          title: data.title,
          color: color,
          delete: () =>
              ref.read(todoStateProvider.notifier).deleteItem(data.id ?? 0),
          editWidget: const SizedBox.shrink(),
          switcher: const Icon(
            AntDesign.checkcircle,
            color: Appconst.kGreen,
          ),
          description: data.desc,
          start: data.startTime,
          end: data.endTime,
        );
      },
    );
  }
}
