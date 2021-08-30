import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:quiz/User/quiz_user.dart';

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({Key key, this.onEnd, this.onStart}) : super(key: key);
  final VoidCallback onStart;
  final VoidCallback onEnd;

  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  CountDownController _controller = CountDownController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Stream stream = QuizUser.getInstance().timerController.stream;
    stream.listen((value) {
      _controller.restart(); //= CountDownController();
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // _controller.start();
    return Container(
      child: CircularCountDownTimer(
        controller: _controller,
        duration: 5,
        initialDuration: 0,
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 2,
        ringColor: Colors.grey[300],
        ringGradient: null,
        fillColor: Colors.pinkAccent,
        fillGradient: null,
        backgroundColor: Colors.deepPurple[400],
        backgroundGradient: null,
        strokeWidth: 20.0,
        strokeCap: StrokeCap.round,
        textStyle: TextStyle(
            fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
        textFormat: CountdownTextFormat.S,
        isReverse: false,
        isReverseAnimation: false,
        isTimerTextShown: true,
        autoStart: false,
        onStart: () {
          print('Countdown Started');
          widget.onStart();
        },
        onComplete: () {
          print('Countdown Ended');
          widget.onEnd();
        },
      ),
    );
  }
}
