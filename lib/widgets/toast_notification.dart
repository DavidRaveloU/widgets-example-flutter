import 'package:flutter/material.dart';

enum NotificationType {
  error,
  success,
  warning,
  info,
}

class ToastNotification extends StatefulWidget {
  final NotificationType? notificationType;
  final String message;
  final int? seconds;

  const ToastNotification({
    Key? key,
    this.notificationType,
    required this.message,
    this.seconds = 3,
  }) : super(key: key);

  @override
  State<ToastNotification> createState() => _ToastNotificationState();
}

class _ToastNotificationState extends State<ToastNotification> {
  var updateInterval = const Duration(milliseconds: 100);
  bool _isVisible = true;
  Color color = Colors.green;
  late Icon icon = const Icon(
    Icons.check_circle,
    color: Colors.green,
    size: 40,
  );
  String title = 'Success';
  double _percentage = 1.0;

  @override
  void initState() {
    super.initState();
    _setupNotification();
    _startProgressTimer();
  }

  void _setupNotification() {
    switch (widget.notificationType) {
      case NotificationType.error:
        title = 'Error';
        color = Colors.red;
        icon = Icon(
          Icons.error,
          color: color,
          size: 40,
        );
        break;
      case NotificationType.info:
        title = 'Information';
        color = Colors.blue;
        icon = Icon(
          Icons.info_rounded,
          color: color,
          size: 40,
        );
        break;
      case NotificationType.warning:
        title = 'Warning';
        color = Colors.amber;
        icon = Icon(
          Icons.warning_outlined,
          color: color,
          size: 40,
        );
        break;
      default:
        break;
    }
  }

  void _startProgressTimer() {
    double interval = widget.seconds!.toDouble();
    Stream.periodic(updateInterval, (count) {
      return count * updateInterval.inMilliseconds;
    })
        .take(interval * 1000 ~/ updateInterval.inMilliseconds)
        .listen((elapsedTime) {
      setState(() {
        _percentage = 1 - (elapsedTime / (interval * 1000));
      });
    });

    Future.delayed(Duration(seconds: widget.seconds!), () {
      setState(() {
        _isVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeWidth = MediaQuery.of(context).size.width;
    return Visibility(
      visible: _isVisible,
      child: _buildNotification(sizeWidth),
    );
  }

  Widget _buildNotification(double sizeWidth) {
    return Stack(
      children: [
        Center(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: sizeWidth / 1.3,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(left: BorderSide(color: color, width: 4)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 104, 104, 104)
                            .withOpacity(0.5),
                        blurRadius: 4,
                        spreadRadius: 2,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ),
              ClipRect(
                child: SizedBox(
                  width: sizeWidth / 1.3,
                  height: 70,
                  child: Column(
                    children: [
                      const Spacer(),
                      _buildNotificationContent(),
                      const Spacer(),
                      _buildProgressBar(sizeWidth),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildNotificationContent() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: icon,
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: '\n${widget.message}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
        IconButton(
            onPressed: () {},
            splashRadius: 1,
            icon: Icon(
              Icons.close,
              color: Colors.grey[500],
              size: 18,
            ))
      ],
    );
  }

  Widget _buildProgressBar(double sizeWidth) {
    return AnimatedContainer(
      duration: updateInterval,
      width: sizeWidth / 1.3 * (_percentage > 0 ? _percentage : 0),
      height: 4,
      color: Colors.grey[500],
    );
  }
}
