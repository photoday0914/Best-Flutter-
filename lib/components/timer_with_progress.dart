import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:bbb/values/app_colors.dart';

class TimerWithProgressBar extends StatefulWidget {
  final int initialDuration;
  final VoidCallback onClose;
  final VoidCallback onComplete; // Add callback for completion

  const TimerWithProgressBar({
    super.key,
    required this.initialDuration,
    required this.onClose,
    required this.onComplete, // Pass callback
  });

  @override
  _TimerWithProgressBarState createState() => _TimerWithProgressBarState();
}

class _TimerWithProgressBarState extends State<TimerWithProgressBar>
    with SingleTickerProviderStateMixin {
  late int duration;
  late int totalTime;
  late int currentTime;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    duration = widget.initialDuration;
    totalTime = duration;
    currentTime = duration;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: duration),
    );

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onClose();
        widget.onComplete();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _adjustTimer(int seconds) {
    setState(() {
      currentTime = (currentTime * _animation.value).toInt();
      debugPrint('${currentTime.toString()} ${seconds}');
      currentTime += seconds;
      totalTime += seconds;
      if (currentTime < 0) currentTime = 0;

      _controller.duration = Duration(seconds: currentTime);
      _controller.reset();
      _controller.forward();
    });
  }

  String _formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        color: AppColors.primaryColor, // Move color inside the decoration
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 10),
          Text(
            _formatTime(
                totalTime - (currentTime * _animation.value).toInt() - 1),
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: LinearProgressIndicator(
              value: 1 -
                  ((currentTime * _animation.value).toInt() /
                      (totalTime == 0 ? 1 : totalTime)),
              backgroundColor: Colors.grey,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              minHeight: 3,
            ),
          ),
          const SizedBox(width: 5),
          const SizedBox(width: 5),
          SizedBox(
            width: 40,
            height: 25,
            child: ElevatedButton(
              onPressed: () => _adjustTimer(30),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(20, 20),
              ),
              child: const Text(
                "+30s",
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          const SizedBox(width: 5),
          SizedBox(
            width: 40,
            height: 25,
            child: ElevatedButton(
              onPressed: () => _adjustTimer(-30),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(20, 20),
              ),
              child: const Text(
                "-30s",
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(
              Icons.close,
              size: 18,
              color: Colors.white,
            ),
            onPressed: widget.onClose,
          ),
        ],
      ),
    );
  }
}
