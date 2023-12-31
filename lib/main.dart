import 'package:flutter/material.dart';
import 'package:widgets_example/widgets/rating_component.dart';

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
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            RatingComponent(
              onButtonSelected: (value) {
                print(value);
              },
              voidCallback: () {
                print('button used');
              },
            )
            /*DropdownSelectmenu(
              options: [
                OptionTap(
                    icon: const Icon(
                      Icons.facebook,
                      color: Colors.lightBlue,
                    ),
                    text: 'Facebook',
                    onTap: () {
                      print('Option 1');
                    }),
                OptionTap(
                    text: 'Option 2',
                    onTap: () {
                      print('Option 2');
                    }),
                OptionTap(
                    text: 'Option 3',
                    onTap: () {
                      print('Option 3');
                    }),
              ],
            ),
            ToastNotification(
              message: 'Este es un texto',
              notificationType: NotificationType.info,
            )
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
            ) */
          ],
        ),
      )),
    );
  }
}
