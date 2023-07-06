import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_with_riverpod/common/utils/constants.dart';
import 'package:todo_with_riverpod/common/widgets/custom_text_field.dart';
import 'package:todo_with_riverpod/common/widgets/hieght_spacer.dart';
import 'package:todo_with_riverpod/common/widgets/reuseable_text.dart';
import 'package:todo_with_riverpod/common/widgets/text_style.dart';
import 'package:todo_with_riverpod/common/widgets/width_spacer.dart';
import 'package:todo_with_riverpod/features/todo/controllers/todo/todo_provider.dart';
import 'package:todo_with_riverpod/features/todo/pages/add.dart';
import 'package:todo_with_riverpod/features/todo/widgets/completed_tasks.dart';
import 'package:todo_with_riverpod/features/todo/widgets/day_after_tomorrow.dart';

import '../widgets/today_tasks.dart';
import '../widgets/tomorrow_list.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  final TextEditingController search = TextEditingController();
  late final TabController tabController =
      TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    ref.watch(todoStateProvider.notifier).refresh();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                        text: 'Dashboard',
                        style: appStyle(18, Appconst.kLight, FontWeight.bold)),
                    Container(
                      width: 25.w,
                      height: 25.w,
                      decoration: const BoxDecoration(
                          color: Appconst.kLight,
                          borderRadius: BorderRadius.all(Radius.circular(9))),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AddTask(),
                          ));
                        },
                        child: const Icon(
                          Icons.add,
                          color: Appconst.kBkDark,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const HeightSpacer(height: 20),
              CustomTextField(
                hintText: 'Search',
                controller: search,
                prefixIcon: Container(
                  padding: EdgeInsets.all(14.h),
                  child: GestureDetector(
                    onTap: null,
                    child: const Icon(
                      AntDesign.search1,
                      color: Appconst.kGreyLight,
                    ),
                  ),
                ),
                suffixIcon: const Icon(
                  FontAwesome.sliders,
                  color: Appconst.kGreyLight,
                ),
              ),
              const HeightSpacer(height: 15)
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              const HeightSpacer(height: 25),
              Row(
                children: [
                  const Icon(
                    FontAwesome.tasks,
                    size: 20,
                    color: Appconst.kLight,
                  ),
                  const WidthSpacer(width: 10),
                  ReusableText(
                    text: "Today's Tasks",
                    style: appStyle(18, Appconst.kLight, FontWeight.bold),
                  )
                ],
              ),
              const HeightSpacer(height: 25),
              Container(
                decoration: BoxDecoration(
                  color: Appconst.kLight,
                  borderRadius: BorderRadius.circular(Appconst.kRadius),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      color: Appconst.kGreyLight,
                      borderRadius:
                          BorderRadius.all(Radius.circular(Appconst.kRadius))),
                  controller: tabController,
                  labelPadding: EdgeInsets.zero,
                  isScrollable: false,
                  labelStyle:
                      appStyle(24, Appconst.kBlueLight, FontWeight.w700),
                  labelColor: Appconst.kBlueLight,
                  unselectedLabelColor: Appconst.kLight,
                  tabs: [
                    Tab(
                      child: SizedBox(
                        width: Appconst.kHeight * 0.5,
                        child: Center(
                          child: ReusableText(
                              text: 'Pending',
                              style: appStyle(
                                  16, Appconst.kBkDark, FontWeight.bold)),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        width: Appconst.kHeight * 0.5,
                        padding: EdgeInsets.only(left: 30.w),
                        child: Center(
                          child: ReusableText(
                              text: 'Completed',
                              style: appStyle(
                                  16, Appconst.kBkDark, FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const HeightSpacer(height: 20),
              SizedBox(
                height: Appconst.kHeight * 0.3,
                width: Appconst.kWidth,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Appconst.kRadius),
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Container(
                        color: Appconst.kBkLight,
                        height: Appconst.kHeight * 0.3,
                        child: const TodayTasks(),
                      ),
                      Container(
                        color: Appconst.kBkLight,
                        height: Appconst.kHeight * 0.3,
                        child: const CompletedTasks(),
                      )
                    ],
                  ),
                ),
              ),
              const HeightSpacer(height: 20),
              const TommorowsList(),
              const HeightSpacer(height: 20),
              const DayAfterTomorrow()
            ],
          ),
        ),
      ),
    );
  }
}
