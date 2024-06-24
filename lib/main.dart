import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tasks/blocs/task_bloc.dart';
import 'package:my_tasks/provider/provider.dart';
import 'package:my_tasks/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TaskProvider()),
      BlocProvider(create: (_) => TaskBloc()),],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MyTasks',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home()
    );
  }
}
