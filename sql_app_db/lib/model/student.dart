import 'dart:typed_data';

class Student {
  final id;
  final String name;
  final int age;
  final String couser;
  final Uint8List image;

  Student(
      {required this.id,
      required this.name,
      required this.age,
      required this.couser,required this.image});

  factory Student.fromMap({required Map data}) {
    return Student(
        id: data['id'],
        name: data['name'],
        age: data['age'],
        couser: data['couser'],
        image: data['image']
        );
  }
}
