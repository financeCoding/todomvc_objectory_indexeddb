import 'dart:html';
import 'model.dart';
import 'package:web_ui/web_ui.dart';
import 'package:objectory/objectory.dart';
class FormComponent extends WebComponent {
  void addTodo(e) {
    InputElement _newTodo = query('#new-todo');
    e.preventDefault(); // don't submit the form
    if (_newTodo.value == '') return;
    var todo = new Todo(_newTodo.value);
    app.todos.add(todo);
    objectory.save(todo);
    _newTodo.value = '';
  }
}