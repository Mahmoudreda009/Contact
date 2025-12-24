import 'dart:io';

class User {
  final String name;
  final String email;
  final String phone;
  final File? image;

  User({
    required this.name,
    required this.email,
    required this.phone,
    this.image,
  });
}
