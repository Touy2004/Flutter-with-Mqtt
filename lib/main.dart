import 'package:flutter/material.dart';
import 'package:iot_workshop/pages/home.dart';
import 'package:iot_workshop/services/mqtt.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetDataMqttProvider())
      ],
      child: MaterialApp(
        title: "Mqtt App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.purple),
        home:const HomePage(),
      ),
    );
  }
}

