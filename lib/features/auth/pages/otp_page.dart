import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:todo_with_riverpod/common/utils/constants.dart';
import 'package:todo_with_riverpod/common/widgets/hieght_spacer.dart';
import 'package:todo_with_riverpod/common/widgets/reuseable_text.dart';
import 'package:todo_with_riverpod/common/widgets/text_style.dart';
import 'package:todo_with_riverpod/features/auth/controllers/auth_controller.dart';

class OtpPage extends ConsumerWidget {
  final String smsCodeId;
  final String phone;
  const OtpPage({super.key, required this.smsCodeId, required this.phone});

  void verifyOtp(BuildContext context, WidgetRef ref, String smsCode) {
    ref.read(authControllerProvider).verifyOtp(
        context: context,
        smsCodeId: smsCodeId,
        smsCode: smsCode,
        mounted: true);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeightSpacer(
              height: Appconst.kHeight * 0.12,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Image.asset(
                'assets/images/todo.png',
                width: Appconst.kWidth * 0.5,
              ),
            ),
            const HeightSpacer(height: 26),
            ReusableText(
              text: 'Enter your otp code',
              style: appStyle(18, Appconst.kLight, FontWeight.bold),
            ),
            const HeightSpacer(height: 26),
            Pinput(
              length: 6,
              showCursor: true,
              onCompleted: (value) {
                if (value.length == 6) {
                  return verifyOtp(context, ref, value);
                }
              },
              onSubmitted: (value) {
                if (value.length == 6) {
                  return verifyOtp(context, ref, value);
                }
              },
            )
          ],
        ),
      )),
    );
  }
}
