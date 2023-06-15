import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_with_riverpod/common/utils/constants.dart';
import 'package:todo_with_riverpod/common/widgets/custom_otn_btn.dart';

import '../../../common/widgets/hieght_spacer.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Appconst.kHeight,
      width: Appconst.kWidth,
      color: Appconst.kBkDark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Image.asset('assets/images/todo.png'),
          ),
          const HeightSpacer(height: 50),
          CustomOtlBtn(
            width: Appconst.kWidth * 0.9,
            height: Appconst.kHeight * 0.06,
            color: Appconst.kLight,
            text: 'Login with a phone number',
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
            },
          )
        ],
      ),
    );
  }
}
