import 'package:flutter/material.dart';
import 'package:todo_with_riverpod/common/utils/constants.dart';
import 'package:todo_with_riverpod/common/widgets/reuseable_text.dart';
import 'package:todo_with_riverpod/common/widgets/text_style.dart';

import '../../../common/widgets/width_spacer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ReuseableText(
              text: 'Todo',
              style: appStyle(26, Appconst.kBlueLight, FontWeight.bold),
            ),
            const WidthSpacer(
              width: 20,
            ),
            ReuseableText(
              text: 'Todo',
              style: appStyle(26, Appconst.kBlueLight, FontWeight.bold),
            ),
            const WidthSpacer(
              width: 20,
            ),
            ReuseableText(
              text: 'Todo',
              style: appStyle(26, Appconst.kBlueLight, FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
