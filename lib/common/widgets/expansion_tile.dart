import 'package:flutter/material.dart';

import 'package:todo_with_riverpod/common/utils/constants.dart';
import 'package:todo_with_riverpod/common/widgets/titles.dart';

class XpansionTile extends StatelessWidget {
  final String text;
  final String text2;
  final void Function(bool)? onExpansionChanged;
  final List<Widget> children;
  final Widget? trailing;

  const XpansionTile({
    Key? key,
    required this.text,
    required this.text2,
    required this.children,
    this.onExpansionChanged,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Appconst.kBkLight,
          borderRadius: BorderRadius.all(
            Radius.circular(Appconst.kRadius),
          )),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: BottomTitles(
            text: text,
            text2: text2,
          ),
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          onExpansionChanged: onExpansionChanged,
          controlAffinity: ListTileControlAffinity.trailing,
          trailing: trailing,
          children: children,
        ),
      ),
    );
  }
}
