import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:simpletodo/presentation/page/add_page.dart';
import 'package:simpletodo/presentation/page/home_page.dart';
import 'package:simpletodo/presentation/viewmodel/task_view_model.dart';

void main() => runApp(SimpleToDo());
const ADD_PAGE = '/add';
const LIGHT_MODE_COLOR = 0xFFE9E9E9;
const DARK_MODE_COLOR = 0xFF283032;
const DARK_MODE_SHADOW_LIGHT_COLOR = 0xFF363940;

class SimpleToDo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<TaskViewModel>(
      create: (context) => TaskViewModel(),
      child: NeumorphicApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.system,
        theme: NeumorphicThemeData(
          baseColor: Color(LIGHT_MODE_COLOR),
          lightSource: LightSource.topLeft,
        ),
        darkTheme: NeumorphicThemeData(
          baseColor: Color(DARK_MODE_COLOR),
          shadowLightColor: Color(DARK_MODE_SHADOW_LIGHT_COLOR),
          lightSource: LightSource.topLeft,
        ),
        home: HomePage(),
        routes: {
          ADD_PAGE: (context) => AddPage(),
        },
      ));
}
