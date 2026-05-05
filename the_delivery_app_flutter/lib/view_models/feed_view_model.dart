import 'package:flutter/foundation.dart';

import '../models/device_profile.dart';
import '../models/location.dart';
import '../repositories/i_feed_repository.dart';
import '../state/feed_state.dart';

class FeedViewModel extends ChangeNotifier {
  final IFoodRepository _repository;

  FeedState _state = const FeedState(feedItems: [], isLoading: false);

  static const _defaultLocation = Location(51.5, -0.1);
  static const _defaultDevice = DeviceProfile(
    screenResolutionX: 390,
    screenResolutionY: 844,
    dpi: 2.0,
    dataTransferRateMbps: 10.0,
  );

  FeedViewModel({required IFoodRepository repository})
      : _repository = repository;

  FeedState getState() => _state;

  Future<void> loadFeed() async {
    _state = const FeedState(feedItems: [], isLoading: true);
    notifyListeners();

    try {
      await _repository.initializeFeed(
        location: _defaultLocation,
        device: _defaultDevice,
      );
      final items = await _repository.loadNextChunk();
      _state = FeedState(feedItems: items, isLoading: false);
    } catch (e) {
      _state = FeedState(
        feedItems: [],
        isLoading: false,
        errorMessage: e.toString(),
      );
    }

    notifyListeners();
  }
}
