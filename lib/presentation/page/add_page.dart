import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:simpletodo/data/model/task.dart';
import 'package:simpletodo/main.dart';

import '../viewmodel/task_view_model.dart';

const String ADD_PAGE_TITLE = 'New Task';

class AddPage extends StatefulWidget {
  AddPage({Key key}) : super(key: key);

  @override
  AddPageState createState() => AddPageState();
}

class AddPageState extends State<AddPage> {
  String _title = "";
  String _imagePath = "";

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);

    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text(
          ADD_PAGE_TITLE,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
        ),
        buttonStyle:
            NeumorphicStyle(depth: 0.0, boxShape: NeumorphicBoxShape.circle()),
      ),
      body: NeumorphicBackground(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  neuImageWrapper(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.only(left: 8),
                height: 36,
                child: Text(
                  "description",
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Flexible(
                flex: 5,
                child: Stack(fit: StackFit.expand, children: [neuTextField()])),
            Flexible(
                flex: 2,
                child: Stack(fit: StackFit.expand, children: [
                  neuAddButton(() => {
                        viewModel.insertTask(Task(
                            title: _title,
                            path: _imagePath.isEmpty ? "" : _imagePath,
                            isFinish: 1))
                      })
                ])),
          ],
        ),
      ),
    );
  }

  _checkTitleEmpty(Function insertAction, BuildContext context) {
    if (_title.isNotEmpty) {
      insertAction();
      Navigator.pop(context);
    }
  }

  _titleChangedListener(String title) {
    setState(() {
      _title = title;
    });
  }

  _getGalleryImage() async {
    PickedFile image =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _imagePath = image.path;
    });
  }

  // todo 과연 사용할까?
  _getCameraImage() async {
    PickedFile image = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      _imagePath = image.path;
    });
  }

  Widget neuImageWrapper() {
    return Center(
      child: NeumorphicButton(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 24),
          padding: EdgeInsets.zero,
          duration: Duration(milliseconds: 300),
          onPressed: () {
            _getGalleryImage();
          },
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.circle(),
            depth: 5,
            intensity: 1.0,
          ),
          child: neuImageSurface()),
    );
  }

  Widget neuImageSurface() {
    return Neumorphic(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.all(5.0),
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.circle(),
        shape: NeumorphicShape.flat,
      ),
      child: SizedBox.expand(
          child: _imagePath.isNotEmpty
              ? Image.file(File(_imagePath), fit: BoxFit.fill)
              : SvgPicture.asset('assets/need_photo.svg', fit: BoxFit.contain)),
    );
  }

  Widget neuTextField() {
    return Neumorphic(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      style: NeumorphicStyle(
        depth: -3.0,
        intensity: 1.0,
        boxShape:
            NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(8))),
      ),
      child: TextField(
        decoration: InputDecoration(border: InputBorder.none),
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        maxLines: null,
        onChanged: (title) => _titleChangedListener(title),
      ),
    );
  }

  Widget neuAddButton(Function insertAction) {
    return NeumorphicButton(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 24),
      style: NeumorphicStyle(
        depth: _title.isEmpty ? 0.0 : 5.0,
        intensity: 1.0,
        boxShape:
            NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(8))),
      ),
      child: Center(
          child: Text("Add Task",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: _title.isEmpty ? Colors.black26 : Colors.blueAccent,
              ))),
      onPressed: () {
        _checkTitleEmpty(() => {insertAction()}, context);
      },
    );
  }
}
