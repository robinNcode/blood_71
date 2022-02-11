class BloodGroupModel {
  final int id;
  final String bloodGroup;

  const BloodGroupModel(this.id, this.bloodGroup);

  static findAll() {
    return const [
      'A+',
      'A-',
      'B+',
      'B-',
      'O+',
      'O-',
      'AB+',
      'AB-',
    ];
  }
}
