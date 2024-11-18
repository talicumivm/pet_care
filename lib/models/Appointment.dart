// models/Appointment.dart
class Appointment {
  final String title;        // Título de la cita (por ejemplo, tipo de servicio)
  final String description;   // Descripción de la cita
  final DateTime time;        // Fecha y hora de la cita

  Appointment({
    required this.title,
    required this.description,
    required this.time,
  });

  // Método para crear una instancia de Appointment desde un JSON
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      title: json['title'] as String,
      description: json['description'] as String,
      time: DateTime.parse(json['time'] as String),
    );
  }

  // Método para convertir la instancia de Appointment a un JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'time': time.toIso8601String(),
    };
  }
}
