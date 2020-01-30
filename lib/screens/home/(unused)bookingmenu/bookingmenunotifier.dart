import 'package:flutter/widgets.dart';

class BookingMenuNotifier extends ChangeNotifier {
  bool _openbookingmenu = false;
  int _pageNumber = 0;

  void togglemenu() {
    _openbookingmenu = !_openbookingmenu;
    notifyListeners();
  }

  set setPageNumber(int page) {
    _pageNumber = page;
    notifyListeners();
  }

  bool get isOpen => _openbookingmenu;
  int get getpageNumber => _pageNumber;
}
