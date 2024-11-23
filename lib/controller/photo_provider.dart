import 'package:flutter/material.dart';
import 'package:wallpaper_app/model/model.dart';
import 'package:wallpaper_app/services/service.dart';

class PhotoProvider with ChangeNotifier {
  final PexelsService _pexelsService = PexelsService();
  final List<Photo> _photos = [];
  int _currentPage = 1;
  bool _isLoading = false;
  int _selectedTabIndex = 0; // Use _selectedTabIndex to avoid name conflicts

  List<Photo> get photos => _photos.reversed.toList();
  bool get isLoading => _isLoading;
  int get selectedTabIndex => _selectedTabIndex; // Getter for selectedTabIndex

  Future<void> fetchPhotos() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final newPhotos = await _pexelsService.fetchPhotos(_currentPage);
      _photos.addAll(newPhotos);
      _currentPage++;
    } catch (e) {
      print('Error fetching photos: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void changeTab(int tabIndex) {
    _selectedTabIndex = tabIndex; // Modify the private _selectedTabIndex
    notifyListeners(); // Notify listeners to update UI
  }
}
