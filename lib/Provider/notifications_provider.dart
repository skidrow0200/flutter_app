import 'package:flutter/foundation.dart';

class NotificationProvider with ChangeNotifier {
  bool isNotification = false;
  int unreadCount = 0;

  void setNotification(bool value) {
    isNotification = value;
    notifyListeners();
  }

  void setUnreadCount(int count) {
    unreadCount = count;
    notifyListeners();
  }
}
