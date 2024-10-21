import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatear la fecha y la hora

class AddAppointmentDialog extends StatefulWidget {
  final DateTime selectedDay;

  AddAppointmentDialog({required this.selectedDay});

  @override
  _AddAppointmentDialogState createState() => _AddAppointmentDialogState();
}

class _AddAppointmentDialogState extends State<AddAppointmentDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    // Inicializar la hora con la hora actual por defecto
    _selectedTime = TimeOfDay.now();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Formatear la fecha y la hora seleccionada para mostrarlas
    String formattedDate = DateFormat('yyyy-MM-dd').format(widget.selectedDay);
    String formattedTime = _selectedTime.format(context);

    return AlertDialog(
      title: Text("Agregar Cita para $formattedDate"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Título"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un título';
                }
                return null;
              },
              onSaved: (value) => _title = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Descripción"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una descripción';
                }
                return null;
              },
              onSaved: (value) => _description = value!,
            ),
            SizedBox(height: 10),
            // Mostrar la hora seleccionada y botón para elegir la hora
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Hora seleccionada: $formattedTime"),
                TextButton(
                  onPressed: () => _selectTime(context),
                  child: Text("Seleccionar hora"),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Cancelar
          },
          child: Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              // Combinar la fecha y la hora seleccionadas
              final appointmentDateTime = DateTime(
                widget.selectedDay.year,
                widget.selectedDay.month,
                widget.selectedDay.day,
                _selectedTime.hour,
                _selectedTime.minute,
              );
              Navigator.pop(context, {
                'title': _title,
                'description': _description,
                'datetime': appointmentDateTime,
              });
            }
          },
          child: Text("Guardar"),
        ),
      ],
    );
  }
}
