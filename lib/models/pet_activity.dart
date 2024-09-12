class PetActivity {
  String name;
  String status; // "No comenzado", "En proceso", "Terminado"

  PetActivity({
    required this.name,
    this.status = "No comenzado", // Estado inicial por defecto
  });

  void updateStatus(String newStatus) {
    status = newStatus;
  }
}
