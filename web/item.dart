import 'dart:html';
import 'model.dart';
import 'package:web_ui/web_ui.dart';
import 'package:objectory/objectory.dart';

class TodoItemComponent extends WebComponent {
  Todo todo;
  bool _editing = false;

  String get _editingClass => _editing ? 'editing' : '';
  String get _completedClass => todo.done ? 'completed' : '';

  void edit(e) {
    // Note: we could preserve the old edit value if the user canceled their
    // edit and restarts, but then we'd need to provide a different user
    // gesture to get back to a clean state. For the current simple UI, clean
    // state is the right default--it matches how most programs operate.
    _edit.value = todo.task;
    _editing = true;

    // Need to focus after watcher.dispatch() makes the edit box visible
    // TODO(jmesserly): need a better way to handle this. Perhaps via
    // watchers, but but those are blocked on this bug:
    // https://github.com/dart-lang/dart-web-components/issues/53
    window.setTimeout(() {
      // IE doesn't support autofocus. Also in Firefox, it appears to only
      // work the first time. So use .focus().
      _edit.focus();
      // Move cursor to end on Firefox and IE.
      _edit.value = '';
      _edit.value = todo.task;
    }, 0);
  }

  void update(e) {
    e.preventDefault(); // don't submit the form
    if (!_editing) return; // bail if user canceled
    todo.task = _edit.value;
    _editing = false;
  }

  void maybeCancel(KeyboardEvent e) {
    // TODO(jmesserly): dart:html should have a KeyCodes enumeration.
    // http://code.google.com/p/dart/issues/detail?id=5540
    if (e.keyCode == 27/*ASCII Escape*/) {
      _editing = false;
    }
  }

  void delete(e) {
    var list = app.todos;
    var index = list.indexOf(todo);
    if (index != -1) {
      list.removeRange(index, 1);
    }
    todo.remove();
  }
}