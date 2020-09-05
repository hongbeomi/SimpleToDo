import 'dart:math';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import 'package:simpletodo/data/model/task.dart';
import 'package:simpletodo/main.dart';
import 'package:simpletodo/presentation/component/custom_add_button_provider.dart';
import 'package:simpletodo/presentation/component/task_item_view.dart';
import 'package:simpletodo/presentation/viewmodel/task_view_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  final String title = 'All Task';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final PreloadPageController _pageController =
      PreloadPageController(initialPage: 0, viewportFraction: 0.8);
  double page = 0;

  bool _handlePageNotification(ScrollNotification notification) {
    if (notification.depth == 0 && notification is ScrollUpdateNotification) {
      setState(() {
        page = _pageController.page;
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context, listen: true);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: NeumorphicTheme.baseColor(context),
      appBar: NeumorphicAppBar(),
      body: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Text(
                widget.title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 48,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: viewModel.loadTasks(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
                  return snapshot.hasData
                      ? NotificationListener<ScrollNotification>(
                          onNotification: _handlePageNotification,
                          child: PreloadPageView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              preloadPagesCount: 10,
                              controller: _pageController,
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                final scale =
                                    max(0.9, (1.0 - (index - page).abs()));
                                final depth =
                                    max(0.5, (1.0 - (index - page).abs()));

                                return Dismissible(
                                  key: UniqueKey(),
                                  direction: DismissDirection.up,
                                  onDismissed: (direction) {
                                    showUndoFlushBar(
                                        context,
                                        () => {
                                              viewModel.insertTask(
                                                  snapshot.data[index])
                                            });
                                      viewModel.deleteTask(
                                          snapshot.data[index].id
                                      );
                                  },
                                  child: TaskItemView(
                                    key: UniqueKey(),
                                    task: snapshot.data[index] ?? [],
                                    scale: scale,
                                    scaleDepth: depth,
                                  ),
                                );
                              }),
                        )
                      : Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 104,
                child: NeumorphicButton(
                    margin: EdgeInsets.all(24),
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.convex,
                        depth: 2.0,
                        intensity: 1.0,
                        boxShape: NeumorphicBoxShape.path(
                            AddButtonShapePathProvider())),
                    onPressed: () {
                      Navigator.pushNamed(context, ADD_PAGE);
                    },
                    child: SvgPicture.asset('assets/plus_blue.svg',
                        width: 36, height: 36)),
              ),
            )
          ])),
    );
  }

  showUndoFlushBar(BuildContext context, Function undoAction) {
    Flushbar(
      maxWidth: 120,
      message: " ",
      mainButton: NeumorphicButton(
        child: Row(
          children: [
            Icon(Icons.refresh),
            SizedBox(
              width: 10,
            ),
            Text(
              "undo",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
        onPressed: () {
          undoAction();
        },
      ),
      padding: EdgeInsets.all(24),
      backgroundColor: Colors.transparent,
      duration: Duration(seconds: 2),
    ).show(context);
  }
}
