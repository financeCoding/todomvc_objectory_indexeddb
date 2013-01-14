import 'model.dart';
import 'package:web_ui/web_ui.dart';

class ToggleComponent extends WebComponent {
  bool get allChecked => app.todos.length > 0 &&
      app.todos.every((t) => t.done);

  void markAll(e) => app.todos.forEach((t) { t.done = _toggleAll.checked; });
}