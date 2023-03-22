import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/TodoListProvider.dart';
import 'Widgets/Home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      ChangeNotifierProvider(

        create: (context)=>TodoListProvider(),
        child: const MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en'),
            Locale('vi'),
          ],
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          home:  MyHomePage(),
        ),

      );


  }
}


