import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_with_riverpod/common/utils/constants.dart';
import 'package:todo_with_riverpod/common/widgets/custom_otn_btn.dart';
import 'package:todo_with_riverpod/common/widgets/hieght_spacer.dart';
import 'package:todo_with_riverpod/common/widgets/reuseable_text.dart';
import 'package:todo_with_riverpod/common/widgets/text_style.dart';

import '../../../common/widgets/custom_text_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController phone = TextEditingController();
  Country country = Country(
      phoneCode: "1",
      countryCode: "US",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "USA",
      example: "USA",
      displayName: "United States",
      displayNameNoCountryCode: "US",
      e164Key: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Image.asset(
                'assets/images/todo.png',
                width: 300,
              ),
            ),
            const HeightSpacer(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 16.w),
              child: ReuseableText(
                  text: 'Plese enter your phone number',
                  style: appStyle(
                    17,
                    Appconst.kLight,
                    FontWeight.w500,
                  )),
            ),
            const HeightSpacer(height: 20),
            Center(
              child: CustomTextField(
                controller: phone,
                prefixIcon: Container(
                  padding: const EdgeInsets.all(14),
                  child: GestureDetector(
                    onTap: () {
                      showCountryPicker(
                          context: context,
                          countryListTheme: CountryListThemeData(
                              backgroundColor: Appconst.kLight,
                              bottomSheetHeight: Appconst.kHeight * 0.6,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    Appconst.kRadius,
                                  ),
                                  topRight: Radius.circular(
                                    Appconst.kRadius,
                                  ))),
                          onSelect: (code) {
                            setState(() {});
                          });
                    },
                    child: ReuseableText(
                        text: country.flagEmoji + country.phoneCode,
                        style: appStyle(18, Appconst.kBkDark, FontWeight.bold)),
                  ),
                ),
                keyboardType: TextInputType.number,
                hintText: 'Enter phone number',
                hintStyle: appStyle(16, Appconst.kBkDark, FontWeight.w600),
              ),
            ),
            const HeightSpacer(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomOtlBtn(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OtpPage(),
                    )),
                width: Appconst.kWidth * 0.9,
                height: Appconst.kHeight * 0.075,
                color: Appconst.kBkDark,
                color2: Appconst.kLight,
                text: 'Send Code',
              ),
            )
          ],
        ),
      )),
    );
  }
}
