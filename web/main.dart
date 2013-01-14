import 'dart:html';
import 'model.dart';
import 'package:web_ui/watcher.dart';

main() {
  // listen on changes to #hash in the URL
  // Note: listen on both popState and hashChange, because IE9 doens't support
  // history API, and it doesn't work properly on Opera 12.
  // See http://dartbug.com/5483
  updateFilters(e) {
    viewModel.showIncomplete = window.location.hash != '#/completed';
    viewModel.showDone = window.location.hash != '#/active';
    dispatch();
  }
  window.on.hashChange.add(updateFilters);
  window.on.popState.add(updateFilters);
}

