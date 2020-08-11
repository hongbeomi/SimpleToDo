
class Task {

  final int id;
  final String title;
  final String description;
  final int isFinish;

  Task({this.id, this.title, this.description, this.isFinish});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isFinish': isFinish
    };
  }

}