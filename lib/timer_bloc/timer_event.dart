part of 'timer_bloc.dart';

@immutable
abstract class TimerEvent {
  const TimerEvent();
}

class Start extends TimerEvent {
  final int minutes;
  const Start(this.minutes);
}

class Reset extends TimerEvent {
  const Reset();
}

class Tick extends TimerEvent {
  final int duration;

  Tick({@required this.duration});

  @override
  String toString() => "Tick { duration: $duration }";
}
