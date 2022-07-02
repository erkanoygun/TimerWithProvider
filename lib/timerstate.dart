import 'dart:async';
import 'package:flutter/material.dart';
import 'package:duration_picker/duration_picker.dart';

class MyTimer extends ChangeNotifier {
  late Timer _timer;
  bool buttonactivate = true;
  Duration duration = const Duration(minutes: 0, seconds: 0);
  Duration? resetduration = const Duration(minutes: 0, seconds: 0);
  double defoultwithcontainer = 300;
  bool iscoutdown = false;

  selecktTime(BuildContext context) async {
    defoultwithcontainer = 300;
    Duration? newduration = await showDurationPicker(
      context: context,
      initialTime: duration,
      baseUnit: BaseUnit.second,
    );
    duration = newduration ?? duration;
    resetduration = newduration ?? resetduration;
    defoultwithcontainer = (defoultwithcontainer / duration.inSeconds);
    notifyListeners();
  }

  void setCountDown() {
    const countSecond = 1;
    final seconds = duration.inSeconds - countSecond;
    if (duration.inSeconds == 0) {
      iscoutdown = false;
      _timer.cancel();
      buttonactivate = true;
      duration = const Duration(minutes: 0, seconds: 0);
    } else {
      duration = Duration(seconds: seconds);
    }
    notifyListeners();
  }

  void stopTimer() {
    iscoutdown = false;
    _timer.cancel();
    notifyListeners();
  }

  void resetTimer() {
    duration = resetduration!;
    notifyListeners();
  }

  void startTimer() {
    iscoutdown = true;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) => setCountDown());
    notifyListeners();
  }

  void isbuttonActivate() {
    buttonactivate = !buttonactivate;
  }
}
