import 'package:flutter/material.dart';

class AccordionContainer extends StatefulWidget {
  final Text number;
  final Text title;
  final Text textContent;
  final double maxHeight;
  final Color backgroundColorshrink;
  final Color backgroundColorExpand;
  final double width;
  final LinearGradient gradient;

  const AccordionContainer({
    super.key,
    required this.number,
    required this.title,
    required this.textContent,
    required this.backgroundColorshrink,
    required this.backgroundColorExpand,
    required this.width,
    required this.gradient,
    required this.maxHeight,
  });

  @override
  State<AccordionContainer> createState() => AaccordionStateContainer();
}

class AaccordionStateContainer extends State<AccordionContainer> {
  bool _expand = true;
  double _sizeContainer = 60;

  void _toggleExpand() {
    setState(() {
      _expand = !_expand;
      _sizeContainer = _expand ? 60 : widget.maxHeight;
    });
  }

  Widget _buildNumberWidget() {
    return Visibility(
      visible: _expand,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: widget.gradient,
        ),
        child: Center(child: widget.number),
      ),
    );
  }

  Widget _buildTitleWidget() {
    return !_expand
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: widget.backgroundColorshrink,
            ),
            child: widget.title,
          )
        : widget.title;
  }

  Widget _buildExpandButton() {
    return IconButton(
      splashRadius: 1,
      onPressed: _toggleExpand,
      icon: _expand
          ? const Icon(Icons.expand_more)
          : const Icon(Icons.expand_less),
    );
  }

  Widget _buildContent() {
    return Visibility(
      visible: !_expand,
      child: Expanded(
        child: Align(alignment: Alignment.topLeft, child: widget.textContent),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleExpand,
      child: AnimatedContainer(
        height: _sizeContainer,
        width: widget.width,
        duration: const Duration(milliseconds: 400),
        curve: Curves.decelerate,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: _expand
              ? widget.backgroundColorshrink
              : widget.backgroundColorExpand,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                _buildNumberWidget(),
                Visibility(visible: _expand, child: const SizedBox(width: 20)),
                _buildTitleWidget(),
                const Spacer(),
                _buildExpandButton(),
              ],
            ),
            _buildContent(),
          ],
        ),
      ),
    );
  }
}
