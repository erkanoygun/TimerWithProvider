import 'package:countdown_app/timerstate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyTimer mystate = Provider.of<MyTimer>(context, listen: false);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () async {
          await mystate.selecktTime(context);
        },
        child: const Icon(
          Icons.timer,
          color: Colors.black,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Timer Page",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TimeAnimation(),
            CountText(),
            Buttons(),
            const ScaleBar(),
          ],
        ),
      ),
    );
  }
}

class CountText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
      child: Consumer<MyTimer>(
        builder: (context, mystate, child) {
          String strDigits(int n) => n.toString().padLeft(2, '0');
          final minutes = strDigits(mystate.duration.inMinutes.remainder(60));
          final seconds = strDigits(mystate.duration.inSeconds.remainder(60));
          return Text(
            "$minutes : $seconds",
            style: Theme.of(context).textTheme.headline2,
          );
        },
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Consumer<MyTimer>(
          builder: (context, mystate, child) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: mystate.duration.inSeconds != 0
                  ? () {
                      if (mystate.buttonactivate) {
                        mystate.startTimer();
                        mystate.isbuttonActivate();
                      } else {
                        mystate.stopTimer();
                        mystate.isbuttonActivate();
                      }
                    }
                  : null,
              child: mystate.buttonactivate
                  ? const Icon(
                      Icons.play_arrow,
                      size: 80,
                    )
                  : const Icon(
                      Icons.stop_circle,
                      size: 80,
                    ),
            );
          },
        ),
        Consumer<MyTimer>(
          builder: (context, myState, child) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: myState.buttonactivate
                  ? () {
                      myState.resetTimer();
                    }
                  : null,
              child: const Icon(
                Icons.restart_alt,
                size: 80,
              ),
            );
          },
        ),
      ],
    );
  }
}

class ScaleBar extends StatelessWidget {
  const ScaleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.red,
            ),
            width: 300,
            height: 15,
          ),
          Consumer<MyTimer>(
            builder: (context, mystate, child) {
              print("cosn: ${mystate.defoultwithcontainer}");
              return AnimatedContainer(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.green,
                ),
                width:
                    mystate.defoultwithcontainer * mystate.duration.inSeconds,
                height: 15,
                duration: const Duration(microseconds: 1),
                curve: Curves.bounceIn,
              );
            },
          ),
        ],
      ),
    );
  }
}

class TimeAnimation extends StatelessWidget {
  const TimeAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyTimer>(
      builder: (context, mystate, child) {
        if (mystate.iscoutdown) {
          return Lottie.asset(
            'assets/animation/animation.json',
            width: 120,
            height: 120,
            fit: BoxFit.fill,
          );
        } else {
          return Container(
            width: 120,
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'assets/images/image.PNG',
                  scale: 4.5,
                ),
                const Text(
                  "Paused",
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
