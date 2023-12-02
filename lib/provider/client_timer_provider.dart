import 'package:flutter/material.dart';
import 'package:typeracer/models/client_timer.dart';

class ClientTimerProvider extends ChangeNotifier {
  ClientTimer _clientTimer = ClientTimer(timer: {'countDown': '', 'msg': ''});

  Map<String, dynamic> get clientTimer => _clientTimer.toJson();

  setClientTimer(timer) {
    _clientTimer = ClientTimer(timer: timer);
    notifyListeners();
  }
}
