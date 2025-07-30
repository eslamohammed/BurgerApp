import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/feature/task/ui/task_screen.dart';

class TaskApp extends StatelessWidget {
  // final AppRouter appRouter;
  // const RamoApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 3264),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Ramo",
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Color.fromARGB(255, 20, 115, 128), // Example color
          scaffoldBackgroundColor: Color(
            0xFFF5F5F5,
          ), // Example background color
        ),
        home: TaskScreen(),
      ),
    );
  }
}
