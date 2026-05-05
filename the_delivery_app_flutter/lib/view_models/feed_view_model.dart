import 'package:flutter/foundation.dart';

import '../state/feed_state.dart';

class FeedViewModel extends ChangeNotifier {
  FeedState _state = const FeedState(feedItems: [], isLoading: false);

  FeedViewModel();

  FeedState getState() => _state;

  Future<void> loadFeed() async {
    _state = const FeedState(feedItems: [], isLoading: true);
    notifyListeners();

    // No backend connected yet — feed stays empty until wired up.
    _state = const FeedState(feedItems: [], isLoading: false);
    notifyListeners();
  }
}
