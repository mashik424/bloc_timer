part of 'timer_bloc.dart';

@immutable
abstract class TimerState {
  const TimerState();
}

class TimeUpdate extends TimerState {
  final int secondsPassed;

  const TimeUpdate(this.secondsPassed);
}

class TimerStopped extends TimerState {
  const TimerStopped();
}
