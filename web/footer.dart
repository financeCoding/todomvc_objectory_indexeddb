import 'dart:html';
import 'model.dart';
import 'package:web_ui/web_ui.dart';

class FooterComponent extends WebComponent {
  int get doneCount {
    int res = 0;
    app.todos.forEach((t) { if (t.done) res++; });
    return res;
  }

  int get remaining => app.todos.length - doneCount;

  String get allClass {
    if (window.location.hash == '' || window.location.hash == '#/') {
      return 'selected';
    } else {
      return null;
    }
  }
  String get activeClass =>
      window.location.hash == '#/active' ?  'selected' : null;

  String get completedClass =>
      window.location.hash == '#/completed' ?  'selected' : null;

  void clearDone(e) {
    app.todos = app.todos.filter((t) => !t.done);
  }

  bool get anyDone => doneCount > 0;
}