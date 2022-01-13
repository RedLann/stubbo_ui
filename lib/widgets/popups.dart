import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';

Future<void> showMessageRevealDialog(
  BuildContext context,
  String message, {
  Duration duration = const Duration(milliseconds: 200),
}) async {
  showGeneralDialog(
    barrierLabel: message,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    transitionDuration: duration,
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Container(
        color: Colors.green.withOpacity(0.7),
        child: Center(
          child: Column(
            children: [
              Text(
                message,
                style: TextStyle(fontSize: 40),
              ),
              ElevatedButton(onPressed: () => Navigator.pop(context), child: Text("Close!"))
            ],
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return CircularRevealAnimation(
        child: child,
        animation: anim1,
        centerAlignment: Alignment.center,
      );
    },
  );
}
