import 'package:flutter/material.dart';

class BarracksNavigator extends ChangeNotifier {
  int _pageIndex = 0;
  PageController _pageController = PageController();

  int get getIndex => _pageIndex;

  PageController get getPageController => _pageController;

  setPageIndex(int index) {
    _pageIndex = index;
    _pageController.jumpToPage(index);
    notifyListeners();
  }
}
