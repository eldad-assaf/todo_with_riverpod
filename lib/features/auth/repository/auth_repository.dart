import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_with_riverpod/common/helpers/db_helper.dart';
import 'package:todo_with_riverpod/common/widgets/show_dialog.dart';

import '../../../common/routes/routes.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(auth: FirebaseAuth.instance);
});

class AuthRepository {
  final FirebaseAuth auth;
  AuthRepository({required this.auth});

  void verifyOtp({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: smsCodeId, smsCode: smsCode);

      await auth.signInWithCredential(credential);
      if (!mounted) {
        return;
      }
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.home,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void sentOtp({required BuildContext context, required String phone}) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (error) {
          showAlertDialog(context: context, message: error.message.toString());
        },
        codeSent: (smsCodeId, resendCodeId) {
          DbHelper.createUser(1);
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.otp, (route) => false,
              arguments: {'phone': phone, 'smsCodeId': smsCodeId});
        },
        codeAutoRetrievalTimeout: (smsCodeId) {},
      );
    } on FirebaseAuth catch (e) {
      log('FirebaseAuth exception : ${e.toString()}');
      showAlertDialog(context: context, message: e.toString());
    }
  }
}
