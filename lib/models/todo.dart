class Todo {
  String title;
  String detail;
  bool isDone;

  Todo({
    required this.title,
    required this.detail,
    this.isDone = false,
  });
}
