import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_with_riverpod/common/utils/constants.dart';
import 'package:todo_with_riverpod/common/widgets/hieght_spacer.dart';
import 'package:todo_with_riverpod/common/widgets/reuseable_text.dart';
import 'package:todo_with_riverpod/common/widgets/text_style.dart';
import 'package:todo_with_riverpod/common/widgets/width_spacer.dart';
import 'package:todo_with_riverpod/features/todo/controllers/todo/todo_provider.dart';

class BottomTitles extends StatelessWidget {
  final String text;
  final String text2;
  final Color? clr;

  const BottomTitles(
      {super.key, required this.text, required this.text2, this.clr});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Appconst.kWidth,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer(
              builder: (context, ref, child) {
                var color =
                    ref.read(todoStateProvider.notifier).getRandomColor();
                return Container(
                  height: 80,
                  width: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(Appconst.kRadius),
                    ),

                    ///TODO: ADD DYNAMIC COLOR
                    color: color,
                  ),
                );
              },
            ),
            const WidthSpacer(width: 15),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: text,
                    style: appStyle(24, Appconst.kLight, FontWeight.bold),
                  ),
                  const HeightSpacer(height: 10),
                  ReusableText(
                    text: text2,
                    style: appStyle(12, Appconst.kLight, FontWeight.normal),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
