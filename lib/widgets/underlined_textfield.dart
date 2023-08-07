import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum FieldType {
  email,
  password,
  number,
}

class UnderlinedTextField extends StatefulWidget {
  final double? width;
  final String? hintText;
  final FieldType fieldType;
  final Color? cursorColor;
  final int maxLenght;
  const UnderlinedTextField({
    Key? key,
    this.hintText,
    required this.fieldType,
    this.cursorColor,
    this.width,
    required this.maxLenght,
  }) : super(key: key);

  @override
  State<UnderlinedTextField> createState() => _UnderlinedTextFieldState();
}

class _UnderlinedTextFieldState extends State<UnderlinedTextField> {
  late Color colorDivider = Colors.grey;
  late TextEditingController textEditingController;
  late Text messageInf;
  late int status = 0;
  late bool obscureText = false;
  late TextInputType keyboardType;
  late RegExp regExp = RegExp(r'[\w@.-]');

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    messageInf = const Text('');
    switch (widget.fieldType) {
      case FieldType.email:
        keyboardType = TextInputType.emailAddress;
        break;
      case FieldType.password:
        keyboardType = TextInputType.text;
        obscureText = true;
        break;
      case FieldType.number:
        keyboardType = TextInputType.phone;
        regExp = RegExp(r'[0-9]');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(width: 1)),
              width: widget.width ?? double.infinity,
              child: buildTextField()),
          Divider(
            color: status == 1
                ? Colors.green
                : status == 2
                    ? Colors.red
                    : Colors.grey,
            thickness: 2.5,
            height: 0,
          ),
          const SizedBox(height: 5),
          Builder(builder: (context) {
            return messageInf;
          }),
        ],
      ),
    );
  }

  Widget buildTextField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: textEditingController,
            onChanged: (value) {
              setState(() {
                switch (widget.fieldType) {
                  case FieldType.email:
                    messageInf = validatedEmail(textEditingController.text);
                    if (messageInf.data == 'Correo válido') {
                      status = 1;
                    } else {
                      status = 2;
                    }
                    break;
                  case FieldType.password:
                    messageInf = validatedPassword(textEditingController.text);
                    if (messageInf.data == 'Contraseña válida') {
                      status = 1;
                    } else {
                      status = 2;
                    }
                    break;
                  case FieldType.number:
                    break;
                  default:
                    break;
                }
              });
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(regExp),
              LengthLimitingTextInputFormatter(widget.maxLenght),
            ],
            obscureText: obscureText,
            cursorColor: widget.cursorColor ?? Colors.black,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              border: InputBorder.none,
              hintText: widget.hintText ?? '',
            ),
          ),
        ),
        const SizedBox(width: 5),
        if (widget.fieldType == FieldType.password)
          buildPasswordVisibilityButton(),
        if (status == 1)
          const Icon(
            Icons.check_circle_rounded,
            color: Colors.green,
          )
        else if (status == 2)
          const Icon(
            Icons.error_rounded,
            color: Colors.red,
          )
      ],
    );
  }

  Widget buildPasswordVisibilityButton() {
    return IconButton(
      splashRadius: 1,
      onPressed: () {
        setState(() {
          obscureText = !obscureText;
        });
      },
      icon: Icon(
        obscureText ? Icons.visibility : Icons.visibility_off,
        color: Colors.grey,
      ),
    );
  }
}

Text validatedEmail(String email) {
  RegExp regExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!regExp.hasMatch(email)) {
    return const Text(
      'Correo inválido',
      style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
    );
  } else {
    return const Text(
      'Correo válido',
      style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
    );
  }
}

Text validatedPassword(String password) {
  RegExp regExp = RegExp(r'^(?=.*\d+)(?=.*[A-Z]+).{8,}$');
  if (!regExp.hasMatch(password)) {
    return const Text(
      'La contraseña debe tener al menos 8 caracteres, una letra mayúscula y un número',
      style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
    );
  } else {
    return const Text(
      'Contraseña válida',
      style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
    );
  }
}
