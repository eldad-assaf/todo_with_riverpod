import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/models/user_model.dart';

final userProvider = StateNotifierProvider<UserState, List<UserModel>>((ref) {
  return UserState();
});

class UserState extends StateNotifier<List<UserModel>> {
  UserState() : super([]);

  
}
