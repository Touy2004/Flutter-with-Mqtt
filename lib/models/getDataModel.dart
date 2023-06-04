class SensorData {
  final double humidity;
  final double temperature;

  SensorData({
    required this.humidity,
    required this.temperature,
  });
  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      humidity: json['humidity'].toDouble(),
      temperature: json['temperature'].toDouble(),
    );
  }
}
