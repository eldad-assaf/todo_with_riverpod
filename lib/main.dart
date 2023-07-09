import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_with_riverpod/common/models/user_model.dart';
import 'package:todo_with_riverpod/common/utils/constants.dart';
import 'package:todo_with_riverpod/features/auth/controllers/user_controller.dart';
import 'package:todo_with_riverpod/features/onboarding/pages/onboarding.dart';
import 'package:todo_with_riverpod/features/todo/pages/home_page.dart';
import 'package:todo_with_riverpod/firebase_options.dart';

import 'common/routes/routes.dart';

//com.googleusercontent.apps.909749972047-qe35hu9osht7v28j552qaekm0j2i5u87
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  static final defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);

  static final defaultDarkColorScheme = ColorScheme.fromSwatch(
      brightness: Brightness.dark, primarySwatch: Colors.blue);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(userProvider.notifier).refresh();
    List<UserModel> users = ref.watch(userProvider);
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 825),
      minTextAdapt: true,
      builder: (context, child) {
        return DynamicColorBuilder(
            builder: (lightColorSceheme, darkColorscheme) {
          return MaterialApp(
            title: 'Todo With Riverpod!!!',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Appconst.kBkDark,
              primarySwatch: Colors.blue,
              useMaterial3: true,
              colorScheme: lightColorSceheme ?? defaultLightColorScheme,
            ),
            darkTheme: ThemeData(
              colorScheme: darkColorscheme ?? defaultDarkColorScheme,
              scaffoldBackgroundColor: Appconst.kBkDark,
              useMaterial3: true,
            ),
            themeMode: ThemeMode.dark,
            onGenerateRoute: Routes.onGenerateRoutes,
            home: users.isNotEmpty ? const Onboarding() : const HomePage(),
          );
        });
      },
    );
  }
}
