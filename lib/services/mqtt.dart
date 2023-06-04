import 'dart:convert';
import 'dart:developer' show log;
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import '../models/getDataModel.dart';

late MqttServerClient client;

class GetDataMqttProvider with ChangeNotifier {
  final List<SensorData> _data = [];
  List<SensorData> get data => _data;
  Future<void> connect() async {
    client = MqttServerClient.withPort(
        "broker.hivemq.com", "mqttClientId_Mb1", 1883);
    client.keepAlivePeriod = 30;
    client.autoReconnect = true;
    //if you have user password you can add to connect(user,password)
    await client.connect().onError((error, stackTrace) {
      log("error -> $error");
      return null;
    });
    client.onConnected = () {
      log('MQTT connected');
    };

    client.onDisconnected = () {
      log('MQTT disconnected');
    };

    client.onSubscribed = (String topic) {
      log('MQTT subscribed to $topic');
    };
    log("connected");

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      client.subscribe("ceitiot/test/mqtt/dht/touy", MqttQos.atMostOnce);
      client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final recMess = c![0].payload as MqttPublishMessage;
        final jsonString =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        final data = SensorData.fromJson(jsonDecode(jsonString));
        _data.add(data);
        log(jsonString);
        notifyListeners();
      });
    }
  }
}