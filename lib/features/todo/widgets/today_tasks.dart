import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_with_riverpod/features/todo/pages/update_task.dart';
import 'package:todo_with_riverpod/features/todo/widgets/todo_tile.dart';

import '../../../common/models/task_model.dart';
import '../../../common/utils/constants.dart';
import '../controllers/todo/todo_provider.dart';

class TodayTasks extends ConsumerWidget {
  const TodayTasks({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Task> listData = ref.watch(todoStateProvider);
    String today = ref.read(todoStateProvider.notifier).getToday();

    List<Task> todayList = listData
        .where((task) => task.isCompleted == 0 && task.date!.contains(today))
        .toList();

    return ListView.builder(
      itemCount: todayList.length,
      itemBuilder: (context, index) {
        final data = todayList[index];
        bool isCompleted = ref.read(todoStateProvider.notifier).getStatus(data);
        dynamic color = ref.read(todoStateProvider.notifier).getRandomColor();
        return TodoTile(
          title: data.title,
          color: color,
          delete: () =>
              ref.read(todoStateProvider.notifier).deleteItem(data.id ?? 0),
          editWidget: GestureDetector(
            onTap: () {
              titles = data.title.toString();
              descs = data.desc.toString();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UpdateTask(
                  id: data.id ?? 0,
                ),
              ));
            },
            child: const Icon(MaterialCommunityIcons.circle_edit_outline),
          ),
          switcher: Switch(
            value: isCompleted,
            onChanged: (value) {
              ref.read(todoStateProvider.notifier).markAsCompleted(
                    data.id ?? 0,
                    data.title!,
                    data.desc!,
                    1,
                    data.date!,
                    data.startTime!,
                    data.endTime!,
                  );
            },
          ),
          description: data.desc,
          start: data.startTime,
          end: data.endTime,
        );
      },
    );
  }
}
