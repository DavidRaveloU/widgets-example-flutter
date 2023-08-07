import 'package:flutter/material.dart';

enum FieldType {
  email,
  password,
  number,
}

class CustomTextField extends StatefulWidget {
  final String hintText;
  final FieldType fieldType;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.fieldType,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    TextInputType keyboardType;
    bool obscureText = false;

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
        break;
    }

    return TextField(
      decoration: InputDecoration(
        hintText: widget.hintText,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MyCustomTextFieldPage(),
  ));
}

class MyCustomTextFieldPage extends StatelessWidget {
  const MyCustomTextFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Text Field Example'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                hintText: 'Correo electrónico',
                fieldType: FieldType.email,
              ),
              SizedBox(height: 20),
              CustomTextField(
                hintText: 'Contraseña',
                fieldType: FieldType.password,
              ),
              SizedBox(height: 20),
              CustomTextField(
                hintText: 'Número de teléfono',
                fieldType: FieldType.number,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
