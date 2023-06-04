import 'package:flutter/material.dart';
import 'package:iot_workshop/controllers/publishDataMqtt.dart';
import 'package:iot_workshop/services/mqtt.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool state = false;
  @override
  void initState() {
    context.read<GetDataMqttProvider>().connect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Mqtt App IoT",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(children: [
        Consumer<GetDataMqttProvider>(builder: (context, dataprovider, index) {
          if (dataprovider.data.isEmpty) {
            return const CircularProgressIndicator();
          } else {
            final data = dataprovider.data.last;
            return Center(
              child: Column(children: [
                const SizedBox(
                  height: 50,
                ),
                Text("humidity: ${data.humidity.toString()}"),
                const SizedBox(
                  height: 50,
                ),
                Text("humidity: ${data.temperature.toString()}"),
              ]),
            );
          }
        }),
        Switch(
            value: state,
            activeColor: Colors.red,
            onChanged: (bool value) {
              setState(() {
                state = value;
                mqttPublish(
                    message: (state) ? true : false, topic: "ceit/test/bt");
              });
            })
      ]),
    );
  }
}
