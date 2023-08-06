import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPVerfication extends StatefulWidget {
  final int numberContainer;
  final double borderRadius;

  const OTPVerfication({
    Key? key,
    required this.numberContainer,
    required this.borderRadius,
  })  : assert(numberContainer == 4 ||
            numberContainer == 6 ||
            numberContainer == 8),
        super(key: key);

  @override
  State<OTPVerfication> createState() => _OTPVerficationState();
}

class _OTPVerficationState extends State<OTPVerfication> {
  late List<FocusNode> focusNodes;
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    focusNodes = List.generate(widget.numberContainer, (index) => FocusNode());
    controllers = List.generate(
        widget.numberContainer, (index) => TextEditingController());
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < widget.numberContainer; i++)
            SizedBox(
              height: 68,
              width: 64,
              child: TextFormField(
                onSaved: (newValue) {
                  if (newValue != null) {
                    controllers[i].text = newValue;
                  }
                },
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    i < widget.numberContainer - 1
                        ? focusNodes[i + 1].requestFocus()
                        : focusNodes[i].unfocus();
                  } else {
                    i > 0
                        ? focusNodes[i - 1].requestFocus()
                        : focusNodes[i].unfocus();
                  }
                },
                controller: controllers[i],
                focusNode: focusNodes[i],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(widget.borderRadius)),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
