import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'timer_bloc/timer_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final options = [1, 2, 3, 4, 5, 6, 7];
  int groupValue = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocConsumer<TimerBloc, TimerState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is TimeUpdate) {
                  return _timeText(
                      '${state.secondsPassed ~/ 60}:${(state.secondsPassed % 60).toInt()}');
                }
                return _timeText('00:00');
              },
            ),
            SizedBox(height: 60.0),
            ...List.generate(
              options.length,
              (index) => Row(
                children: [
                  Text(
                    options[index].toString(),
                    style: TextStyle(color: Colors.black),
                  ),
                  Radio(
                    value: options[index],
                    groupValue: groupValue,
                    onChanged: (newValue) {
                      setState(() {
                        groupValue = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 60.0),
            BlocConsumer<TimerBloc, TimerState>(
              listener: (context, state) {
                //print('~~state: $state');
              },
              builder: (context, state) {
                if (state is TimerStopped) {
                  return _Button.start(
                    onPressed: () {
                      context.read<TimerBloc>().add(Start(groupValue));
                    },
                  );
                } else {
                  return _Button.stop(
                    onPressed: () {
                      context.read<TimerBloc>().add(Reset());
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.blueAccent,
        fontSize: 18.0,
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button.start({
    Key key,
    this.label = 'START',
    this.color = Colors.greenAccent,
    @required this.onPressed,
  }) : super(key: key);

  const _Button.stop({
    Key key,
    this.label = 'STOP',
    this.color = Colors.redAccent,
    @required this.onPressed,
  }) : super(key: key);

  final String label;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
      ),
      child: Text(label),
    );
  }
}
