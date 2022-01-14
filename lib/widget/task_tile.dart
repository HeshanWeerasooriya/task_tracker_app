import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:task_tracker/model/task.dart';

class TaskTile extends StatefulWidget {
  final Task tasks;
  const TaskTile({Key? key, required this.tasks}) : super(key: key);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  bool currentlyPlaying = false;

  void _iconTapped() {
    if (currentlyPlaying == false) {
      setState(() {
        currentlyPlaying = true;
      });
      currentlyPlaying = true;
      _animationController.forward();
      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    } else {
      setState(() {
        currentlyPlaying = false;
      });
      _animationController.reverse();
      _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0xFFD9D7F1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                widget.tasks.title,
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              StreamBuilder<int>(
                  stream: _stopWatchTimer.rawTime,
                  initialData: _stopWatchTimer.rawTime.value,
                  builder: ((context, snapshot) {
                    final value = snapshot.data;
                    final displayTime = StopWatchTimer.getDisplayTime(value!,
                        hours: true,
                        minute: true,
                        second: true,
                        milliSecond: false);

                    return Text(
                      displayTime,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    );
                  })),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: _iconTapped,
                    child: AnimatedIcon(
                      progress: _animationController,
                      icon: AnimatedIcons.play_pause,
                      size: 50,
                    ),
                  ),
                  const Icon(
                    Icons.edit,
                    size: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
        if (currentlyPlaying == true)
          const Center(
            child: SpinKitPulse(
              color: Colors.white,
              size: 250.0,
              //  duration: Duration(seconds: 50),
            ),
          ),
      ],
    );
  }
}
