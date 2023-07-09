import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_with_riverpod/common/utils/constants.dart';
import 'package:todo_with_riverpod/common/widgets/reuseable_text.dart';
import 'package:todo_with_riverpod/common/widgets/text_style.dart';

showAlertDialog({
  required BuildContext context,
  required String message,
  String? btnText,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: ReusableText(
          text: 'message',
          style: appStyle(18, Appconst.kLight, FontWeight.w600),
        ),
        contentPadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0.h),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                btnText ?? "OK",
                style: appStyle(18, Appconst.kGreyLight, FontWeight.w600),
              ))
        ],
      );
    },
  );
}
