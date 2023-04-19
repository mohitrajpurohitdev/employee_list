import 'package:employee_list_ui/bloc/app_bloc_observer.dart';
import 'package:employee_list_ui/bloc/employe_managment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screen/home/home_screen.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => EmployeeManagementBloc(),
          ),
        ],
        child: ScreenUtilInit(
            designSize: const Size(428, 926),
            builder: (context, d) {
              return MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  iconTheme: const IconThemeData(color: Colors.blue),
                  primarySwatch: Colors.blue,
                ),
                home: const HomeScreen(),
              );
            }));
  }
}
