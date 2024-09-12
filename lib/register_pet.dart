import 'package:flutter/material.dart';

class RegisterPetScreen extends StatefulWidget {
  @override
  _RegisterPetScreenState createState() => _RegisterPetScreenState();
}

class _RegisterPetScreenState extends State<RegisterPetScreen> {
  String _petName = 'Sin nombre';
  String _petWeight = '0 kg';
  String _petBreed = 'Sin raza';
  String _petAge = '0 años';

  bool _isEditingName = false;
  bool _isEditingWeight = false;
  bool _isEditingBreed = false;
  bool _isEditingAge = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = _petName;
    _weightController.text = _petWeight;
    _breedController.text = _petBreed;
    _ageController.text = _petAge;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _weightController.dispose();
    _breedController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar Mascota"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nombre de la mascota
            _buildEditableField(
              label: 'Nombre de la mascota',
              value: _petName,
              controller: _nameController,
              isEditing: _isEditingName,
              onEdit: () => setState(() => _isEditingName = true),
              onSave: () => setState(() {
                _petName = _nameController.text;
                _isEditingName = false;
              }),
            ),
            SizedBox(height: 16),

            // Peso de la mascota
            _buildEditableField(
              label: 'Peso de la mascota (kg)',
              value: _petWeight,
              controller: _weightController,
              isEditing: _isEditingWeight,
              onEdit: () => setState(() => _isEditingWeight = true),
              onSave: () => setState(() {
                _petWeight = _weightController.text;
                _isEditingWeight = false;
              }),
            ),
            SizedBox(height: 16),

            // Raza de la mascota
            _buildEditableField(
              label: 'Raza de la mascota',
              value: _petBreed,
              controller: _breedController,
              isEditing: _isEditingBreed,
              onEdit: () => setState(() => _isEditingBreed = true),
              onSave: () => setState(() {
                _petBreed = _breedController.text;
                _isEditingBreed = false;
              }),
            ),
            SizedBox(height: 16),

            // Edad de la mascota
            _buildEditableField(
              label: 'Edad de la mascota',
              value: _petAge,
              controller: _ageController,
              isEditing: _isEditingAge,
              onEdit: () => setState(() => _isEditingAge = true),
              onSave: () => setState(() {
                _petAge = _ageController.text;
                _isEditingAge = false;
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required String value,
    required TextEditingController controller,
    required bool isEditing,
    required VoidCallback onEdit,
    required VoidCallback onSave,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Campo de texto o valor actual
        Expanded(
          child: isEditing
              ? TextField(
                  controller: controller,
                  decoration: InputDecoration(labelText: label),
                )
              : Text(
                  '$label: $value',
                  style: TextStyle(fontSize: 18),
                ),
        ),

        // Botón de editar/guardar
        IconButton(
          icon: Icon(isEditing ? Icons.save : Icons.edit),
          onPressed: isEditing ? onSave : onEdit,
          color: Colors.lightGreen,
        ),
      ],
    );
  }
}
