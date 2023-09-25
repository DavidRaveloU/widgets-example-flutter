import 'package:flutter/material.dart';

class RatingComponent extends StatefulWidget {
  /// Sets the height of the container
  final double? height;

  /// Sets the width of the container
  final double? width;

  /// Sets the title of the container
  final String? title;

  /// Sets the description of the container
  final String? descriptionText;

  /// Sets the button color
  final Color? buttonColor;

  /// Sets the button text
  final String? textButton;

  /// Sets the container color
  final Color? backgroundColor;

  /// Sets the close button's background color
  final Color? backgroundColorClose;

  /// Sets the close button's icon color
  final Color? iconCloseColor;

  /// Sets the title color
  final Color? titleColor;

  /// Sets the description color
  final Color? descriptionColor;

  /// Sets the container's border radius
  final double? borderRaduisContainer;

  /// Sets the button's border radius
  final double? borderRadiusButton;

  /// Sets the rating background color
  final Color? backgroundColorRating;

  /// Sets the rating's border radius
  final double? borderRaduisRating;

  /// Sets the rating color
  final Color? ratingColor;

  /// Sets the selected rating color
  final Color? selectRatingColor;

  /// Sets the rating text color
  final Color? ratingTextColor;

  /// Sets the minimum width of the button
  final double? minWidthButton;

  /// Sets the button text color
  final Color? buttonTextColor;

  /// Sets the height of the button
  final double? heightButton;

  /// Sets the button callback
  final VoidCallback voidCallback;

  /// return the button selected callback
  final ValueChanged<int>? onButtonSelected;

  const RatingComponent(
      {super.key,
      this.height,
      this.width,
      this.title,
      this.descriptionText,
      this.buttonColor,
      this.textButton,
      this.backgroundColor,
      this.backgroundColorClose,
      this.iconCloseColor,
      this.titleColor,
      this.descriptionColor,
      this.borderRaduisContainer,
      this.borderRadiusButton,
      this.backgroundColorRating,
      this.borderRaduisRating,
      this.ratingColor,
      this.selectRatingColor,
      this.ratingTextColor,
      this.minWidthButton,
      this.buttonTextColor,
      this.heightButton,
      required this.voidCallback,
      this.onButtonSelected});

  @override
  State<RatingComponent> createState() => _RatingComponentState();
}

class _RatingComponentState extends State<RatingComponent> {
  int _selectButton = -1;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? const Color.fromRGBO(23, 30, 40, 1),
          borderRadius: BorderRadius.circular(widget.borderRaduisContainer ?? 12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: MaterialButton(
                height: 50,
                minWidth: 50,
                onPressed: () {
                  Navigator.pop(context);
                },
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                color: widget.backgroundColorClose ?? const Color.fromRGBO(38, 47, 56, 1),
                child: Icon(
                  Icons.close,
                  color: widget.iconCloseColor ?? Colors.red,
                ),
              )),
          Text(
            widget.title ?? 'How did we do?',
            style: TextStyle(color: widget.titleColor ?? Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 20),
          Text(
            widget.descriptionText ??
                'Please  let us know how we did with your support request. All feedback is appreciated to help us improve our offering!',
            style: TextStyle(color: widget.descriptionColor ?? Colors.white.withOpacity(0.6), fontSize: 14),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(5, (index) {
              final buttonText = (index + 1).toString();

              return MaterialButton(
                height: 50,
                minWidth: 50,
                onPressed: () {
                  setState(() {
                    _selectButton = index;
                  });
                  widget.onButtonSelected!(index + 1);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                color: _selectButton != index
                    ? widget.ratingColor ?? const Color.fromRGBO(38, 47, 56, 1)
                    : widget.selectRatingColor ?? Colors.blueAccent,
                child: Text(
                  buttonText,
                  style: TextStyle(color: widget.ratingTextColor ?? Colors.white),
                ),
              );
            }),
          ),
          const SizedBox(height: 30),
          MaterialButton(
            height: widget.heightButton ?? 40,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.borderRadiusButton ?? 0)),
            minWidth: widget.minWidthButton ?? double.maxFinite,
            color: widget.buttonColor ?? Colors.blueAccent,
            onPressed: widget.voidCallback,
            child: Text(widget.textButton ?? 'SUBMIT',
                style: TextStyle(color: widget.buttonTextColor ?? Colors.white, fontWeight: FontWeight.w700)),
          )
        ],
      ),
    );
  }
}
