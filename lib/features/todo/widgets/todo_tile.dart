import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:todo_with_riverpod/common/utils/constants.dart';
import 'package:todo_with_riverpod/common/widgets/hieght_spacer.dart';
import 'package:todo_with_riverpod/common/widgets/reuseable_text.dart';
import 'package:todo_with_riverpod/common/widgets/text_style.dart';
import 'package:todo_with_riverpod/common/widgets/width_spacer.dart';

class TodoTile extends StatelessWidget {
  final String? title;
  final String? description;
  final String? start;
  final String? end;
  final Widget? editWidget;
  final void Function()? delete;

  final Color? color;
  const TodoTile({
    super.key,
    this.title,
    this.description,
    this.color,
    this.start,
    this.end,
    this.editWidget,
    this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Stack(children: [
        Container(
          padding: EdgeInsets.all(8.h),
          width: Appconst.kWidth,
          decoration: BoxDecoration(
            color: Appconst.kGreyLight,
            borderRadius: BorderRadius.all(
              Radius.circular(Appconst.kRadius),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 80,
                    width: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Appconst.kRadius),
                      ),

                      ///TODO: ADD DYNAMIC COLOR
                      color: color ?? Appconst.kred,
                    ),
                  ),
                  const WidthSpacer(
                    width: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.h),
                    child: SizedBox(
                      width: Appconst.kHeight,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReuseableText(
                              text: title ?? "Title of Todo",
                              style: appStyle(
                                  18, Appconst.kLight, FontWeight.bold),
                            ),
                            const HeightSpacer(height: 3),
                            ReuseableText(
                              text: description ?? "Description of Todo",
                              style: appStyle(
                                  12, Appconst.kLight, FontWeight.bold),
                            ),
                            const HeightSpacer(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: Appconst.kWidth * 0.3,
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.3,
                                      color: Appconst.kGreyDk,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(Appconst.kRadius),
                                    ),
                                    color: Appconst.kBkDark,
                                  ),
                                  child: Center(
                                    child: ReuseableText(
                                      text: "$start | $end",
                                      style: appStyle(12, Appconst.kLight,
                                          FontWeight.normal),
                                    ),
                                  ),
                                ),
                                const WidthSpacer(width: 20),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: editWidget,
                                    ),
                                    const WidthSpacer(width: 20),
                                    GestureDetector(
                                      onTap: delete,
                                      child: const Icon(
                                          MaterialCommunityIcons.delete_circle),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ]),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
