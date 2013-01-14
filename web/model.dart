// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library model;
import 'package:objectory/objectory_browser.dart';
import 'package:web_ui/watcher.dart';
class MainComponent {
  MainComponent();

  bool isVisible(Todo todo) => todo != null &&
      ((showIncomplete && !todo.done) || (showDone && todo.done));

  bool showIncomplete = true;

  bool showDone = true;

  bool get hasElements => app.todos.length > 0;
}

MainComponent _viewModel;
MainComponent get viewModel {
  if (_viewModel == null) {
    _viewModel = new MainComponent();
  }
  return _viewModel;
}

// The real model:

class App {
  List todos;
  resetTodos(List value) {
    todos = value;
    dispatch();
  }
  App() : todos = <Todo>[];
}

class Todo extends PersistentObject {
  String get task => getProperty('task');
  set task(String value) => setProperty('task',value);

  bool get done => getProperty('done');
  set done(bool value) => setProperty('done',value);

  Todo(String newTask) {
    done = false;
    task = newTask;
    saveOnUpdate = true;
  }
}
ObjectoryQueryBuilder get $Todo => new ObjectoryQueryBuilder('Todo');
const DefaultUri = '127.0.0.1:8080';
App _app;
App get app {
  if (_app == null) {
    _app = new App();
     objectory = new ObjectoryWebsocketBrowserImpl(DefaultUri, () =>
         objectory.registerClass('Todo',()=>new Todo('')), true);
     objectory.initDomainModel().then((_) {
       objectory.find($Todo).then((todos) {
         app.resetTodos(todos);
       });
     });
  }
  return _app;
}
