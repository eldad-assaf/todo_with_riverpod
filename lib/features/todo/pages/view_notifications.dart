import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_with_riverpod/common/utils/constants.dart';
import 'package:todo_with_riverpod/common/widgets/hieght_spacer.dart';
import 'package:todo_with_riverpod/common/widgets/reuseable_text.dart';
import 'package:todo_with_riverpod/common/widgets/text_style.dart';
import 'package:todo_with_riverpod/common/widgets/width_spacer.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key, this.payload});

  final String? payload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      body: SafeArea(
          child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Container(
              width: Appconst.kWidth,
              height: Appconst.kHeight * 0.7,
              decoration: BoxDecoration(
                color: Appconst.kBkLight,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    Appconst.kRadius,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: "Reminder",
                      style: appStyle(40, Appconst.kLight, FontWeight.bold),
                    ),
                    const HeightSpacer(height: 5),
                    Container(
                      width: Appconst.kWidth,
                      padding: const EdgeInsets.only(
                        left: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Appconst.kYellow,
                        borderRadius: BorderRadius.all(
                          Radius.circular(9.h),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ReusableText(
                            text: "Today",
                            style:
                                appStyle(14, Appconst.kBkDark, FontWeight.bold),
                          ),
                          const WidthSpacer(width: 15),
                          ReusableText(
                            text: "From : start To end",
                            style:
                                appStyle(14, Appconst.kBkDark, FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const HeightSpacer(
                      height: 10,
                    ),
                    ReusableText(
                      text: "Title",
                      style: appStyle(30, Appconst.kBkDark, FontWeight.bold),
                    ),
                    const HeightSpacer(
                      height: 10,
                    ),
                    Text(
                      "Text",
                      maxLines: 8,
                      textAlign: TextAlign.justify,
                      style: appStyle(16, Appconst.kLight, FontWeight.normal),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              right: 12.w,
              top: -10,
              child: Image.asset(
                'assets/images/bell.png',
                width: 70.w,
                height: 70.h,
              )),
          Positioned(
              bottom: -Appconst.kHeight * 0.148,
              left: 0,
              right: 0,
              child: Image.asset('assets/images/notification.png',
                  width: Appconst.kWidth * 0.8,
                  height: Appconst.kHeight * 0.6)),
        ],
      )),
    );
  }
}
