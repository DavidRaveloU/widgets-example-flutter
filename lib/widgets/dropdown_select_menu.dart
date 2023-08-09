import 'package:flutter/material.dart';

class DropdownSelectmenu extends StatefulWidget {
  final String? titleDropdown;
  final List<OptionTap> options;
  final double? width;

  const DropdownSelectmenu(
      {super.key,
      this.width,
      required this.options,
      this.titleDropdown = 'Select your option'})
      : assert(width == null || width >= 150);

  @override
  State<DropdownSelectmenu> createState() => _DropdownSelectmenuState();
}

class _DropdownSelectmenuState extends State<DropdownSelectmenu> {
  late bool _expand = false;
  Icon iconDropdown = const Icon(
    Icons.arrow_drop_down_rounded,
    color: Colors.black,
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildDropdownHeader(),
        const SizedBox(height: 10),
        buildExpandedOptions(),
      ],
    );
  }

  Widget buildDropdownHeader() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _expand = !_expand;
          if (_expand == true) {
            iconDropdown = const Icon(
              Icons.arrow_drop_up_rounded,
              color: Colors.black,
            );
          } else {
            iconDropdown = const Icon(
              Icons.arrow_drop_down_rounded,
              color: Colors.black,
            );
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 60,
        width: widget.width,
        decoration: BoxDecoration(
            color: Colors.grey[400], borderRadius: BorderRadius.circular(6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                widget.titleDropdown!,
                style: const TextStyle(fontSize: 17),
              ),
            ),
            iconDropdown
          ],
        ),
      ),
    );
  }

  Widget buildExpandedOptions() {
    return Stack(
      children: [
        Visibility(
          visible: _expand,
          child: Container(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            width: widget.width,
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(6)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widget.options,
            ),
          ),
        ),
      ],
    );
  }
}

class OptionTap extends StatefulWidget {
  final Icon? icon;
  final String text;
  final VoidCallback onTap;

  const OptionTap({
    super.key,
    this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  State<OptionTap> createState() => _OptionTapState();
}

class _OptionTapState extends State<OptionTap> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onTap();
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                  child: widget.icon != null ? widget.icon! : const SizedBox()),
              const SizedBox(width: 10),
              Flexible(child: Text(widget.text)),
            ],
          ),
        ),
      ),
    );
  }
}
