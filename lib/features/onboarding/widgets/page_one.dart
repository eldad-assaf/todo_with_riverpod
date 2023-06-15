import 'package:flutter/material.dart';
import 'package:todo_with_riverpod/common/utils/constants.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Appconst.kHeight,
      width: Appconst.kWidth,
      color: Appconst.kBkDark,
    );
  }
}
