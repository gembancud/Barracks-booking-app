import 'package:flutter/widgets.dart';

class BookingMenuNotifier extends ChangeNotifier {
  bool _openbookingmenu = false;

  void togglemenu() {
    _openbookingmenu = !_openbookingmenu;
    notifyListeners();
  }

  bool get isOpen => _openbookingmenu;
}
