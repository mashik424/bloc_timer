import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc() : super(TimerStopped());

  Timer timer;

  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    if (event is Start) {
      if (timer != null) timer.cancel();
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (timer.tick >= (event.minutes * 60)) {
          timer.cancel();
          add(Reset());
        } else {
          add(Tick(duration: timer.tick));
        }
      });
    } else if (event is Reset) {
      timer.cancel();
      yield (const TimerStopped());
    } else if (event is Tick) {
      yield (TimeUpdate(timer.tick));
    }
  }
}
