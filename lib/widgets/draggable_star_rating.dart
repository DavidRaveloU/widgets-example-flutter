import 'package:flutter/material.dart';

class DraggableStarRating extends StatefulWidget {
  const DraggableStarRating({super.key});

  @override
  State<DraggableStarRating> createState() => _DraggableStarRatingState();
}

class _DraggableStarRatingState extends State<DraggableStarRating> {
  double _rating = 0.0;
  final double _starSize = 30.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          double position = details.localPosition.dx;
          if (position < 0) {
            position = 0;
          } else if (position > _starSize * 5) {
            position = _starSize * 5;
          }
          _rating = (position / (_starSize * 5)) * 5;

          _rating = (_rating * 2).round() / 2;
        });
      },
      child: Row(
        children: List.generate(5, (index) {
          Icon starIcon;
          if (_rating >= index + 0.5) {
            starIcon = Icon(
              Icons.star,
              color: Colors.amber,
              size: _starSize,
            );
          } else if (_rating >= index) {
            starIcon = Icon(
              Icons.star_half,
              color: Colors.amber,
              size: _starSize,
            );
          } else {
            starIcon = Icon(
              Icons.star_border,
              color: Colors.amber,
              size: _starSize,
            );
          }

          if (_rating == _rating.floor()) {
            return Center(child: starIcon);
          }
          if (index + 1 == _rating.ceil()) {
            double progress = _rating - _rating.floor();
            return SizedBox(
              width: _starSize,
              child: Stack(
                children: [
                  Center(child: starIcon),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ClipRect(
                      child: SizedBox(
                        width: _starSize * progress,
                        child: starIcon,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return starIcon;
        }),
      ),
    );
  }
}
