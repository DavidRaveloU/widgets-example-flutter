import 'package:flutter/material.dart';

import 'widgets/accordion_container.dart';
import 'widgets/draggable_star_rating.dart';
import 'widgets/otp_verfication.dart';

import 'widgets/underlined_textfield.dart';

void main(List<String> args) {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            DraggableStarRating(),
            SizedBox(height: 20),
            OTPVerfication(borderRadius: 12, numberContainer: 6),
            SizedBox(height: 20),
            AccordionContainer(
                maxHeight: 300,
                backgroundColorExpand: Colors.green,
                backgroundColorshrink: Colors.white,
                width: 400,
                number: Text(
                  '01',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                title: Text(
                  'Title',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                textContent: Text(
                  'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años',
                  style: TextStyle(color: Colors.white),
                ),
                gradient: LinearGradient(
                    colors: [Colors.red, Colors.orange],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight)),
            SizedBox(height: 10),
            UnderlinedTextField(
              hintText: 'Email',
              fieldType: FieldType.email,
              maxLenght: 30,
            ),
            SizedBox(height: 5),
            UnderlinedTextField(
              hintText: 'Password',
              fieldType: FieldType.password,
              maxLenght: 30,
            ),
            SizedBox(height: 5),
            UnderlinedTextField(
              fieldType: FieldType.number,
              maxLenght: 10,
              hintText: 'Number',
            )
          ],
        ),
      )),
    );
  }
}
