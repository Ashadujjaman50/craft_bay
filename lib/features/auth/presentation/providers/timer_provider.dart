import 'dart:async';

import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {

  Timer? _timer;

  bool _isRunnning = false;

  bool get isRunning => _isRunnning;

  int _remainingSeconds = 0;

  int get remainingSeconds => _remainingSeconds;


  void startTimer(int seconds) {

    if (_isRunnning) return;

    _remainingSeconds = seconds;
    _isRunnning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (_){
      _remainingSeconds = _remainingSeconds - 1;
      notifyListeners();
      if (_remainingSeconds <= 0) {
        _timer?.cancel();
        _isRunnning = false;
      }
    });

    notifyListeners();

  }

  void stopTimer(){
    _timer?.cancel();
    _isRunnning = false;
    notifyListeners();
  }


}