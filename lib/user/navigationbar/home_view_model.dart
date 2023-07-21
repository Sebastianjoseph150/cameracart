import 'package:get/get.dart';

class HomviewModel extends GetxController {
  int _navigatorValue = 0;
  get navigatorValue => _navigatorValue;
  void changeSelectedvalue(int selectedValue) {
    _navigatorValue = selectedValue;
    update();
  }
}
